return {
  "idr4n/github-monochrome.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      comments     = { italic = true },
      keywords     = { bold = true },
      functions    = { italic = true },
      variables    = {},
      conditionals = { bold = true },
      loops        = { bold = true },
      floats       = "light",
      sidebars     = "light",
    },

    on_colors = function(c)
      c.bg       = "#ffffff"
      c.bg_dark  = "#fbfbfb"
      c.bg_float = "#f2f2f2"
      c.bg_popup = "#f2f2f2"

      c.fg       = "#5b4f56"
      c.fg_dark  = "#544b5d"
      c.comment  = "#9790A0"
      c.subtle   = "#696969"

      c.red      = "#c91c60"
      c.green    = "#8bb57b"
      c.yellow   = "#d6b36a"
      c.blue     = "#353d61"
      c.magenta  = "#58376c"

      c.orange   = c.yellow
      c.purple   = c.magenta
    end,

    on_highlights = function(hl, c)
      hl.Visual     = { bg = c.bg_float }
      hl.Search     = { bg = c.yellow, fg = c.bg }
      hl.CursorLine = { bg = c.bg_dark }

      hl.FloatBorder = { fg = c.magenta }
      hl.WinSeparator = { fg = c.bg_popup }

      hl.Constant  = { fg = c.yellow }
      hl.String    = { fg = c.green }
      hl.Number    = { fg = c.yellow }
      hl.Boolean   = { fg = c.yellow }

      hl.Comment = { fg = c.comment, italic = true }

      hl.DiagnosticError = { fg = c.red }
      hl.DiagnosticWarn  = { fg = c.yellow }
      hl.DiagnosticInfo  = { fg = c.blue }
      hl.DiagnosticHint  = { fg = c.green }

      hl.IblIndent = { fg = c.bg_popup }
      hl.IblScope  = { fg = c.muted }

      hl.RainbowDelimiterRed    = { fg = c.subtle }
      hl.RainbowDelimiterYellow = { fg = c.comment }
      hl.RainbowDelimiterBlue   = { fg = c.subtle }
      hl.RainbowDelimiterOrange = { fg = c.comment }
      hl.RainbowDelimiterGreen  = { fg = c.subtle }
      hl.RainbowDelimiterViolet = { fg = c.comment }
      hl.RainbowDelimiterCyan   = { fg = c.subtle }

      hl["@property"]            = { italic = true }
      hl["@variable.member"]     = { italic = true }
    end,
  },

  config = function(_, opts)
    require("github-monochrome").setup(opts)
    vim.cmd.colorscheme("github-monochrome")
  end,
}

