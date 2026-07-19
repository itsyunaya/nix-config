return {
	"lualine.nvim",
	lazy = false,
	after = function()
		require("lualine").setup({
			options = {
				theme = "modus-vivendi"
			}
		})
	end
}
