-- important dont remove
vim.opt.runtimepath:prepend(vim.fn.expand("$HOME/.config/kitty/nvim"))
require("kittynvim")
-- important dont remove

require("keybinds")
require("config.lazy")

vim.bo.modified = false
vim.o.number = false
vim.o.scrolloff = 5
vim.o.sidescrolloff = 8
vim.o.smoothscroll = true

