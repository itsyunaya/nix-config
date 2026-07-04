return {
	"transparent.nvim",
	lazy = false,
	after = function()
		require("transparent").setup({
			-- the groups are named according to the scheme "Startup[section name]"
			extra_groups = { "Startupheader", "Startupsubheader", "Startupbody" }
		})

		vim.api.nvim_create_autocmd("UIEnter", {
			callback = function()
				vim.cmd("TransparentEnable")
			end,
		})
	end
}