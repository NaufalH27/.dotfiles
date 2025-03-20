return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            variant = "dawn", -- auto, main, moon, or dawn
            dark_variant = "dawn", -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,
            enable = {
                terminal = true,
                legacy_highlights = true,
                migrations = true,
            },
            styles = {
                bold = true,
                italic = true,
                transparency = false,
            },
        })
        vim.cmd("colorscheme rose-pine")
    end
}

