return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "php", "phpdoc", "bash", "c", "go", "html", "java",
          "javascript", "json", "kotlin", "lua", "markdown",
          "markdown_inline", "python", "query", "regex",
          "rust", "tsx", "typescript", "vim", "yaml",
        },
        auto_install = true,
        highlight = { enabled = true },
        rainbow = { enabled = false },
      }
    end,
  },
}
