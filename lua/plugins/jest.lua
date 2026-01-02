return {
	{
		"David-Kunz/jester",
		opts = {},
		config = function()
			local cmd =
				" ./node_modules/.bin/jest --coverage=false --runInBand --colors --detectOpenHandles -t '$result' -- $file"
			local jester = require("jester")

			vim.keymap.set("n", "<leader>jr", function()
				jester.run({ cmd = "node" .. cmd, escapeRegex = false })
			end)

			vim.keymap.set("n", "<leader>jd", function()
				jester.run({ cmd = "node --inspect-brk" .. cmd, escapeRegex = false })
			end)
		end,
	},
}
