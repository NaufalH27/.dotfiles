return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = {
    options = {
      theme = {
        normal = {
          a = { fg = "#ffffff", bg = "#353d61", gui = "bold" }, -- blue
          b = { fg = "#5b4f56", bg = "#f2f2f2" },
          c = { fg = "#5b4f56", bg = "#fbfbfb" },
        },
        insert = {
          a = { fg = "#ffffff", bg = "#8bb57b", gui = "bold" }, -- green
        },
        visual = {
          a = { fg = "#ffffff", bg = "#d6b36a", gui = "bold" }, -- yellow
        },
        replace = {
          a = { fg = "#ffffff", bg = "#c91c60", gui = "bold" }, -- red
        },
        inactive = {
          a = { fg = "#9790A0", bg = "#fbfbfb" },
          b = { fg = "#9790A0", bg = "#fbfbfb" },
          c = { fg = "#9790A0", bg = "#fbfbfb" },
        },
      },

      component_separators = "", -- square look
      section_separators = "",   -- no arrows
      globalstatus = true,
      disabled_filetypes = { "alpha", "dashboard" },
    },

    sections = {
      lualine_a = {
        { "mode", padding = { left = 2, right = 2 } },
      },
      lualine_b = {
        { "branch", padding = { left = 2, right = 2 } },
      },
      lualine_c = {
        {
          "filename",
          path = 1,
          padding = { left = 2, right = 2 },
        },
      },

      lualine_x = {
        {
          "diagnostics",
          symbols = {
            error = "E ",
            warn  = "W ",
            info  = "I ",
            hint  = "H ",
          },
        },
      },
      lualine_y = {
        { "filetype", padding = { left = 2, right = 2 } },
      },
      lualine_z = {
        { "location", padding = { left = 2, right = 2 } },
      },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

