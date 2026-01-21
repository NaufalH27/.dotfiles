#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="$HOME/.cache/quickshell"
DESKTOP_DIR="/usr/share/applications"
INDEX_DB="$CACHE_DIR/icon-index.db"
META_FILE="$CACHE_DIR/icon-index.meta"
DEFAULT_ICON_DIRS="$HOME/.local/share/icons:/usr/share/icons:/usr/share/pixmaps" 

PREFERRED_ICON_THEME="${PREFERRED_ICON_THEME:-}"
MANUAL_REBUILD=0

while getopts ":n:-:" opt; do
  case "$opt" in
    n)
      PREFERRED_ICON_THEME="$OPTARG"
      ;;
    -)
      [[ "$OPTARG" == "rebuild" ]] && MANUAL_REBUILD=1
      ;;
    :)
      echo "option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "invalid option -$OPTARG" >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))
ICON_DIRS_ENV="${ICON_DIRS:-$DEFAULT_ICON_DIRS}" 
IFS=':' read -r -a ICON_DIRS <<< "$ICON_DIRS_ENV"

mkdir -p "$CACHE_DIR"

get_mtimes() {
  for d in "${ICON_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    printf 'ICON:%s=%s\n' "$d" "$(stat -c %Y "$d")"
  done

  if [[ -d "$DESKTOP_DIR" ]]; then
    printf 'DESKTOP:%s=%s\n' "$DESKTOP_DIR" "$(stat -c %Y "$DESKTOP_DIR")"
  fi
}

build_cache() {
  echo ">> rebuilding icon cache"

  tmp_meta=$(mktemp)
  tmp_tsv=$(mktemp)

  get_mtimes > "$tmp_meta"

  for d in "${ICON_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    find "$d" \( -name '*.png' -o -name '*.svg' \) \( -path '*/pixmaps/*' -o -path '*/apps/*' \) | 
    while IFS= read -r path; do
      name=${path##*/}
      name=${name%.*}
      printf '%s\t%s\n' "$name" "$path"
    done
  done > "$tmp_tsv"

  rm -f "$INDEX_DB"

  sqlite3 "$INDEX_DB" <<SQL
PRAGMA journal_mode = OFF;
PRAGMA synchronous = OFF;
PRAGMA temp_store = MEMORY;

CREATE TABLE icons (
  name TEXT,
  path TEXT
);
CREATE INDEX idx_icons_name ON icons(name);

.mode tabs
.import '$tmp_tsv' icons
SQL

  mv "$tmp_meta" "$META_FILE"
  rm -f "$tmp_tsv"
}

cache_is_valid() {
  [[ -f "$INDEX_DB" && -f "$META_FILE" ]] || return 1
  diff -q "$META_FILE" <(get_mtimes) >/dev/null
}


if (( MANUAL_REBUILD )); then
  build_cache
elif ! cache_is_valid; then
  build_cache
fi


resolve_icon() {
  local icon="$1"

  sqlite3 "$INDEX_DB" <<SQL
SELECT path
FROM icons
WHERE name = '$icon'
ORDER BY
  CASE
    WHEN path LIKE '%/$PREFERRED_ICON_THEME/%' AND path LIKE '%/scalable/%' THEN 0
    WHEN path LIKE '%/$PREFERRED_ICON_THEME/%' THEN 1
    WHEN path LIKE '%/hicolor/%' AND path LIKE '%/scalable/%' THEN 2
    WHEN path LIKE '%/hicolor/%' THEN 3
    WHEN path LIKE '%/pixmaps/%' THEN 4
    WHEN path LIKE '%/scalable/%' THEN 5
    ELSE 6
  END
LIMIT 1;
SQL
}
grep -L '^NoDisplay=true' /usr/share/applications/*.desktop |
while IFS= read -r file; do
  icon=$(yq -p=ini -o=y '.["Desktop Entry"].Icon' "$file")
  icon="${icon#file://}"

  if [[ -z "$icon" ]]; then
    path=null

  elif [[ "$icon" == /* ]]; then
    if [[ -f "$icon" ]]; then
      echo $path
      path="$icon"
    else
      path=null
    fi

  else
    path=$(resolve_icon "$icon" 2>/dev/null || echo null)
  fi

  yq -p=ini -o=y \
      "[\"$file\", .[\"Desktop Entry\"].Name, (.[\"Desktop Entry\"].Terminal // false), .[\"Desktop Entry\"].Exec, \"$path\"] | @csv" \
    "$file"
done

