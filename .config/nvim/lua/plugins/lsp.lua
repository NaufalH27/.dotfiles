return {
    { "williamboman/mason.nvim",
        config = true,
    },

    { "williamboman/mason-lspconfig.nvim", config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright",
                "pylsp",
                "rust_analyzer",
                "gopls",
                "clangd",
                "kotlin_language_server",
                "yamlls",
                "jsonls",
                "efm",
                "taplo",
                "bashls",
                "lua_ls",  -- Correct name for Lua LSP
                "ts_ls",  -- Correct name for TypeScript LSP
                "tailwindcss", -- Correct name for Tailwind CSS LSP
                "cssls", -- Correct name for CSS LSP
                "html",
                "intelephense",
            },
            automatic_installation = true,
        })
    end },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
        },
        lazy = false,
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local function setup_server(server, config)
                config = config or {}
                config.capabilities = capabilities
                lspconfig[server].setup(config)
            end
            setup_server("html", {})
            setup_server("cssls", {})
            setup_server("cssls", {})
            setup_server("tailwindcss", {})
            setup_server("bashls", {})
            setup_server("yamlls", {})
            setup_server("jsonls", {})
            setup_server("taplo", {})
            setup_server("efm", {
                filetypes = { "conf", "ini" },
            })
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            })
            setup_server("pyright", {})
            setup_server("intelephense", {
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
            setup_server("kotlin_language_server", {
                filetypes = { "kotlin" },
            })
            setup_server("gopls", {
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
            })
            setup_server("clangd", {})
        end
    },
}


