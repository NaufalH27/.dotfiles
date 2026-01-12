#!/usr/bin/env sh

set -eu

MODE="${1:-}"

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
TMP="$(mktemp)"

cleanup() {
  rm -f "$TMP"
}
trap cleanup EXIT

case "$MODE" in
  fullscreen)
    grim - > "$TMP"
    ;;
  crop)
    GEOM="$(slurp -d)" || exit 0
    grim -g "$GEOM" - > "$TMP"
    ;;
  *)
    echo "Usage: $0 {fullscreen|crop}" >&2
    exit 1
    ;;
esac

# Ensure non-empty output
if [ -s "$TMP" ]; then
  mv "$TMP" "$FILE"
  wl-copy < "$FILE"
else
  exit 1
fi

