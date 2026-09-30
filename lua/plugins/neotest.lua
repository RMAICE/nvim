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
			-- Rules are checked top to bottom; the first rule whose pattern matches the
			-- test file wins, and its candidates are tried in order inside the service root.
			-- To add a special case, add a rule (optionally with a custom `root` function).
			local jest_config_rules = {
				{ pattern = "%.unit%.spec%.ts$", configs = { "jest.unit.config.ts" } },
				-- analytics/notification run integration specs through their e2e config
				{
					pattern = "%.integration%.spec%.ts$",
					configs = { "jest.integration.config.ts", "jest.e2e.config.ts" },
				},
				{ pattern = "%.e2e%.spec%.ts$", configs = { "jest.e2e.config.ts" } },
			}
			local fallback_configs = { "jest.config.ts", "jest.config.js" }

			-- Service root = nearest dir with a package.json (core/, risk/, ...).
			local function default_root(file)
				return vim.fs.root(file, "package.json") or vim.fn.getcwd()
			end

			local function resolve(file)
				for _, rule in ipairs(jest_config_rules) do
					if file:match(rule.pattern) then
						local root = (rule.root or default_root)(file)
						for _, name in ipairs(vim.list_extend(vim.deepcopy(rule.configs), fallback_configs)) do
							local candidate = root .. "/" .. name
							if vim.uv.fs_stat(candidate) then
								return root, candidate
							end
						end
						return root, nil
					end
				end

				local root = default_root(file)
				for _, name in ipairs(fallback_configs) do
					local candidate = root .. "/" .. name
					if vim.uv.fs_stat(candidate) then
						return root, candidate
					end
				end
				return root, nil
			end

			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npx jest --coverage=false --runInBand --colors --detectOpenHandles",
						jestArguments = function(defaultArguments)
							return defaultArguments
						end,
						jestConfigFile = function(file)
							local _, config = resolve(file)
							return config
						end,
						env = { CI = true },
						cwd = function(file)
							local root = resolve(file)
							return root
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
			vim.keymap.set("n", "<leader>jd", function()
				local bin = vim.fs.find("node_modules/.bin/jest", {
					upward = true,
					path = vim.fn.expand("%:p:h"),
					type = "file",
				})[1]
				require("neotest").run.run({
					jestCommand = "node --no-lazy --inspect-brk "
						.. bin
						.. " --coverage=false --runInBand --colors --detectOpenHandles",
				})
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
