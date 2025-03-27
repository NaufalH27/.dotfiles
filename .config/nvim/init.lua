vim.opt.number = true
vim.opt.cursorline = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 8
vim.o.cursorline = true
vim.o.smoothscroll = true
vim.opt.wildoptions:remove("pum")
vim.o.signcolumn = "yes"

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


vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "retab"
})


vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "MatchParen", { fg = "#ff0000", bg = "NONE" })
    end
})


for i = 2, 8, 2 do
  vim.keymap.set("n", "<leader>in" .. i, function()
    vim.opt.tabstop = i
    vim.opt.shiftwidth = i
    vim.opt.softtabstop = i
    vim.opt.expandtab = true
    print("Indentation set to " .. i)
  end, { desc = "Set indentation to " .. i })
end

