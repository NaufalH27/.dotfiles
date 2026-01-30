return {
  { "williamboman/mason.nvim",
  config = true,
},
{ "williamboman/mason-lspconfig.nvim", config = function()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "pylsp",
      "rust_analyzer",
      "gopls",
      "clangd",
      "yamlls",
      "jsonls",
      "efm",
      "taplo",
      "bashls",
      "lua_ls",
      "ts_ls",
      "tailwindcss",
      "cssls",
      "html",
      "intelephense",
      "jdtls",
      "ts_ls",
    },
    automatic_installation = true,
  })
end },
{
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "jose-elias-alvarez/typescript.nvim",
  },
  lazy = false,
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.config("html", {})
    vim.lsp.config("cssls", {})
    vim.lsp.config("cssls", {})
    vim.lsp.config("tailwindcss", {})
    vim.lsp.config("bashls", {})
    vim.lsp.config("yamlls", {})
    vim.lsp.config("jsonls", {})
    vim.lsp.config("taplo", {})
    vim.lsp.config("efm", {
      filetypes = { "conf", "ini" },
    })
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    vim.lsp.config("pylsp", {
      root_marker = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git", "venv", ".venv" },
    })

    vim.lsp.config("intelephense", {
      settings = {
        intelephense = {
          stubs = { 
            "bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo", "filter", "gd", 
            "hash", "iconv", "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", 
            "openssl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", "regex", "session", 
            "SimpleXML", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml", 
            "xmlreader", "xmlwriter", "yaml", "zip", "zlib" 
          },
          files = {
            maxSize = 5000000,
          },
        },
      },
    })
    vim.lsp.config("kotlin_language_server", {
      cmd = {"kotlin-language-server"},
      filetypes = { "kotlin" },
      root_marker = { "gradlew", ".git" },
    })
    vim.lsp.config("gopls", {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_marker = { "go.work", "go.mod", ".git" },
    })
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--fallback-style=Google" },
      root_marker = { "Makefile", "CMakeLists.txt", ".git" },
    })
    vim.lsp.config("ts_ls", {
      root_marker = { "node_modules", ".git", "packge.json", "package-lock.json" },
    })
    local home = os.getenv("HOME")
    local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
    local lombok_path = home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar"
    local plugins_path = jdtls_path .. "/plugins/"
    local launcher_jar = vim.fn.glob(plugins_path .. "org.eclipse.equinox.launcher_*.jar")
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
    vim.lsp.config("jdtls", {
      filetypes = { "java" },
      cmd = {
        "java",
        "-javaagent:" .. lombok_path,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher_jar,
        "-configuration",
        jdtls_path .. "/config_linux",
        "-data",
        workspace_dir,
      },
      root_marker = { "gradlew", "mvnw", ".git" },
    })
  end
},
{
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
}


}


