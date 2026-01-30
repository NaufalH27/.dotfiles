return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    highlight = { enabled = true },
    rainbow = { enabled = false },
    config = function()
      require'nvim-treesitter'.setup {
        ensure_installed = {
          "php",
          "phpdoc",
          "bash",
          "c",
          "go",
          "html",
          "java",
          "javascript",
          "json",
          "kotlin",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      }
    end
  },
}
