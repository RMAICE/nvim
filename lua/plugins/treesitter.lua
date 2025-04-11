return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "VeryLazy" },
        opts = {
            ensure_installed = {
                'html',
                'css',
                'scss',
                'lua',
                'luadoc',
                'vim',
                'vimdoc',
                'vue',
                'javascript',
                'typescript',
                'json',
                'sql'
            },
            -- Autoinstall languages that are not installed
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
            },
            indent = { enable = true }
        },
        config = function(_, opts)
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
