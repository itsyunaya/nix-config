return {
	"transparent.nvim",
	lazy = false,
	after = function()
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.cmd("TransparentEnable")
			end,
		})
	end
}