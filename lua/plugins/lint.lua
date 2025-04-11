return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "cspell" },
				vue = { "cspell" },
				javascriptreact = { "cspell" },
				typescript = { "cspell" },
				typescriptreact = { "cspell" },
				nunjucks = { "djlint", "cspell" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("linters_by_ft", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end)
		end,
	},
}
