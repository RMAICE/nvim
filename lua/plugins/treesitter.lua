return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"comment",
				"css",
				"diff",
				"git_config",
				"gitignore",
				"html",
				"htmldjango",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"pug",
				"query",
				"scss",
				"sql",
				"tsx",
				"twig",
				"typescript",
				"typespec",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			},
			-- Autoinstall languages that are not installed
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
