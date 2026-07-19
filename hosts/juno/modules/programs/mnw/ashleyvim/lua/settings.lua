vim.opt.encoding = "utf-8"

vim.opt.tabstop = 4;
vim.opt.softtabstop = 4;
vim.opt.shiftwidth = 4;
vim.opt.smartindent = true;

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = " "

vim.diagnostic.config({
	virtual_text = true,
	virtual_text = { prefix = '' },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,

	float = {
		border = "solid",
		source = true,
	},
})

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#" .. _G.theme["bg"] })
