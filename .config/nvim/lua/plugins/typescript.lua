local function on_attach(_, buffer)
  vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
  vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { buffer = buffer, desc = "Rename File" })
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lspconfig").ts_ls.setup({
          on_attach = on_attach,
        })
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ts_ls = {},
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        ts_ls = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  }
