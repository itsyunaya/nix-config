return {
	"lualine.nvim",
	lazy = false,
	after = function()
		-- todo: actually configure lualine
		require("lualine").setup()
	end
}