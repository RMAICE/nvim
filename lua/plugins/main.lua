local function getPath()
	return vim.fn.expand("%:.")
end

return {
	{ "numToStr/Comment.nvim", opts = {} },
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ "tpope/vim-sleuth" },
	{
		"echasnovski/mini.files",
		opts = {},
		version = "*",
		init = function()
			vim.keymap.set("n", "<leader>pv", function()
				MiniFiles.open(getPath())
			end)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { getPath },
				lualine_x = { "diff" },
				lualine_y = { "diagnostics" },
				lualine_z = {},
			},
		},
	},
}
