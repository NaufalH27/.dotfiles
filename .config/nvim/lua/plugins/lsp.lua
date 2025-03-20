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
            setup_server("pyright", {
                root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git", "venv", ".venv")
            })
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
                cmd = {"kotlin-language-server"},
                filetypes = { "kotlin" },
                root_dir = lspconfig.util.root_pattern( "gradlew", ".git" ),
            })
            setup_server("gopls", {
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
            })
            setup_server("clangd", {
                cmd = { "clangd", "--fallback-style=Google" },
                root_dir = lspconfig.util.root_pattern( "Makefile", "CMakeLists.txt", ".git" ),
            })
            setup_server("ts_ls", {
                root_dir = lspconfig.util.root_pattern( "node_modules", ".git", "packge.json", "package-lock.json" ),
            })
            local home = os.getenv("HOME")
            local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
            local lombok_path = home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar"
            local plugins_path = jdtls_path .. "/plugins/"
            local launcher_jar = vim.fn.glob(plugins_path .. "org.eclipse.equinox.launcher_*.jar")
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
            setup_server("jdtls", {
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
                root_dir = lspconfig.util.root_pattern( "gradlew", "mvnw", ".git" ),
            })
            lspconfig.kotlin_language_server.setup({
                cmd = { "/home/nopal/development/kotlin-language-server/server/build/install/server/bin/kotlin-language-server" },
                filetypes = { "kotlin" },
                root_dir = lspconfig.util.root_pattern("gradlew", ".git"),
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
        config = true,
    }


}


