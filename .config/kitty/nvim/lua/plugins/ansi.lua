return {
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            require("colorizer").setup({
                "*", -- Enable for all file types
                ansi = { enable = true }, -- Explicitly enable ANSI color support
            })
        end,
    },

    {
        "powerman/vim-plugin-AnsiEsc",
        event = "BufReadPre",
    },
}


