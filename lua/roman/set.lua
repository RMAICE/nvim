vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 15
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

local space = "·"
vim.opt.listchars = {
	tab = "→ ",
	multispace = space,
	lead = space,
	trail = space,
	nbsp = space,
}
vim.opt.list = true

vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.guicursor:append("a:blinkwait175-blinkoff150-blinkon175")

vim.filetype.add({
	extension = {
		jsonl = "json",
		njk = "nunjucks",
	},
	pattern = {
		[".env..*"] = "sh",
	},
})
vim.treesitter.language.register("twig", "nunjucks")
