return {
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = {
            'rafamadriz/friendly-snippets',
            { 'echasnovski/mini.icons', version = '*' },
        },
        version = '*',
        opts = {
            enabled = function()
                return not (string.find(vim.bo.filetype, "himalaya") or string.find(vim.bo.filetype, "mail") or not (vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.bo.filetype ~= "DressingInput"))
            end,
            keymap = {
                preset = 'default',
                ['<Enter>'] = { 'accept', 'fallback'},
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
                },
            },
            cmdline  = {
                keymap = {
                    preset = 'default',
                },
            },
            signature = {
                enabled = true,
                window = {
                    max_width = 160,
                    max_height = 30,
                    show_documentation = false,
                }
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true
                    },
                },
                list = {
                    cycle = {
                        from_top = true
                    },
                    selection = {
                        auto_insert = false
                    }
                },
                keyword = {
                    range = 'full'
                },
                trigger = {
                    show_on_trigger_character = true,
                },
                menu = {
                    border = "single",
                    winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
                    winblend = 0,
                    draw = {
                        columns = { { 'kind_icon' }, { 'label' } },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return kind_icon
                                end,
                            }
                        }
                    }
                },
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'single',
                        max_width = 180,
                        max_height = 30,
                        winblend = 0,
                        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
                    }
                },
            },
        },
    },
}
