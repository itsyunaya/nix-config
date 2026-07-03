return {
	"transparent.nvim",
	lazy = false,
	after = function()
		require("transparent").setup({
			extra_groups = { "Startupheader" }
		})

		vim.api.nvim_create_autocmd("UIEnter", {
			callback = function()
				vim.cmd("TransparentEnable")
			end,
		})
	end
}