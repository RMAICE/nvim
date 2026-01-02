return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function()
			local lint = require("lint")
			local globalLint = require("lint")

			local cspell_path = vim.fn.stdpath("config") .. "/lua/plugins/cspell.yml"

			lint.linters.cspell.args = {
				"lint",
				"--config",
				cspell_path,
				"--no-color",
				"--no-progress",
				"--no-summary",
				function()
					return "stdin://" .. vim.api.nvim_buf_get_name(0)
				end,
			}

			lint.linters_by_ft = {
				nunjucks = { "djlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("linters_by_ft", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
					globalLint.try_lint("cspell")
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
				globalLint.try_lint("cspell")
			end)
		end,
	},
}
