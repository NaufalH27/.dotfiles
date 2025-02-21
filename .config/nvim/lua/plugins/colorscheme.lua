return {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false, 
      priority = 1000, 
      opts = {
        flavour = "mocha",
        transparent_background = false,
        term_colors = true, 
        styles = {
          comments = { "italic" }, 
          keywords = { "italic" }, 
        },
        integrations = {
          cmp = true, 
          gitsigns = true, 
          nvimtree = true, 
          telescope = true,
          treesitter = true, 
        },
      },
      config = function(_, opts)
        require("catppuccin").setup(opts) 
        vim.cmd.colorscheme("catppuccin") 
      end,
    },
  }
