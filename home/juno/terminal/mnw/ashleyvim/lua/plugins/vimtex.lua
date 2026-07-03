return {
	"vimtex",
	ft = { "tex" },
	after = function()
		require("vimtex").setup()

		vim.g.vimtex_view_method = "zathura"
	end
}