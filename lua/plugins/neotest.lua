return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-jest",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npx jest --coverage=false --runInBand --colors --detectOpenHandles",
						jestArguments = function(defaultArguments)
							return defaultArguments
						end,
						jestConfigFile = "jest.unit.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
						isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
					}),
				},
			})
		end,
		init = function()
			vim.keymap.set("n", "<leader>jt", function()
				require("neotest").run.run()
			end)
			vim.keymap.set("n", "<leader>jf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end)
			vim.keymap.set("n", "<leader>jo", function()
				require("neotest").output.open({ last_run = true })
			end)
		end,
	},
}
