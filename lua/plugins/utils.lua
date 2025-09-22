-- utility plugins
return {
    {
        -- high-performance color highlighter
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        -- Powerful Git integration for Vim
        'tpope/vim-fugitive',
    }
}
