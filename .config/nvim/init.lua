vim.opt.number = true
vim.opt.cursorline = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 8
vim.o.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.backspace = "indent,eol,start"
vim.opt.softtabstop = -1
vim.o.smoothscroll = true
vim.opt.wildoptions:remove("pum")
vim.cmd([[
  autocmd VimEnter * if isdirectory(expand('<afile>:p')) | execute 'cd '.expand('<afile>:p') | endif
  autocmd VimEnter * if filereadable(expand('<afile>:p')) | execute 'cd %:p:h' | endif
]])
require("keybinds")
require("config.lazy")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    max_width = 80,   -- Set the maximum width
    max_height = 20,  -- Set the maximum height
})

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#cdd6f4", bg = "NONE" })  -- Orange border

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "retab"
})


