vim.opt.runtimepath:prepend(vim.fn.expand("$HOME/.config/kitty/nvim"))
require("config.lazy")
require("keybinds")
vim.opt.number = false 
vim.o.scrolloff = 5   
vim.o.sidescrolloff = 8  
vim.o.smoothscroll = true 
vim.opt.swapfile = false

vim.o.termguicolors = true

vim.api.nvim_create_autocmd("QuitPre", {
  pattern = "*",
  command = "silent! qall!"
})
vim.opt.wildoptions:remove("pum")

local api = vim.api
local orig_buf = api.nvim_get_current_buf()
local term_buf = api.nvim_create_buf(false, true)
api.nvim_set_current_buf(term_buf)
vim.bo.scrollback = 100000
local term_chan = api.nvim_open_term(0, {})


local lines = api.nvim_buf_get_lines(orig_buf, 0, -1, true)

api.nvim_chan_send(term_chan, table.concat(lines, "\n") .. "\n")

vim.fn.chanclose(term_chan)

local last_line = #lines
while last_line > 0 and lines[last_line] == "" do
  last_line = last_line - 1
end
if last_line == 0 then last_line = 1 end

api.nvim_win_set_cursor(0, { last_line, 0 })
vim.bo.modified = false
