KITTYVI_PREVIEW_PATH="$HOME/.cache/kitty/vi"
kitten @ get-text --ansi --extent all > "$KITTYVI_PREVIEW_PATH"
kitty @ launch --type=overlay nvim -u "${HOME}/.config/kitty/nvim/init.lua" -- "$KITTYVI_PREVIEW_PATH"
