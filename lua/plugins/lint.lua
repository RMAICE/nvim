return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function()
			local lint = require("lint")
			local globalLint = require("lint")

			lint.linters_by_ft = {
				nunjucks = { "djlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("linters_by_ft", { clear = true })
			local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
					globalLint.try_lint("cspell", { cwd = cwd })
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
				globalLint.try_lint("cspell", { cwd = cwd })
			end)
		end,
	},
}
