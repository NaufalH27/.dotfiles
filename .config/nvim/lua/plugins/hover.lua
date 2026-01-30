return {
    {
      "lewis6991/hover.nvim",
      config = function()
        require("hover").setup {
          init = function()
            require("hover.providers.lsp")
            require("hover.providers.gh")
            require("hover.providers.gh_user")
            require("hover.providers.man")
            require("hover.providers.dictionary")
          end,
          title = true,
        }

        vim.keymap.set("n", "hK", require("hover").hover, { desc = "Hover Documentation" })
        vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "Select Hover Provider" })
      end
    }
}
