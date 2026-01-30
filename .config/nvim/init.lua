vim.opt.number = true
vim.opt.cursorline = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 8
vim.o.cursorline = true
vim.o.smoothscroll = true
vim.opt.wildoptions:remove("pum")
vim.o.signcolumn = "yes"
vim.o.winborder = 'single'


require("keybinds")
require("config.lazy")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    max_width = 80,
    max_height = 40,
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



vim.api.nvim_create_user_command("CI", function(opts)
  local indent = tonumber(opts.args)
  if not indent or indent <= 0 then
    print("Please provide a valid positive number, e.g., :CI 2")
    return
  end

  vim.opt.tabstop = indent
  vim.opt.shiftwidth = indent
  vim.opt.softtabstop = indent
  vim.opt.expandtab = true

  print("Indentation set to " .. indent)
end, {
  nargs = 1,
  desc = "Set code indentation width",
})



vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.opt.swapfile = false

