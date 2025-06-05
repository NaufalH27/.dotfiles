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


vim.api.nvim_create_user_command("Ci", function(opts)
  local indent = tonumber(opts.args)
  if not indent or indent <= 0 then
    print("Please provide a valid positive number, e.g., :Ci 2")
    return
  end
  vim.opt.tabstop = indent
  vim.opt.shiftwidth = indent
  vim.opt.softtabstop = indent
  vim.opt.expandtab = true
  print("Indentation set to " .. indent)
end, {
  nargs = 1,
  complete = function(ArgLead)
    -- Optional completion suggestion
    return { "2", "4", "8" }
  end,
  desc = "Set code indentation width",
})


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

