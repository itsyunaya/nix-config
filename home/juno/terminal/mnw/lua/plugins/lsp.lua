return {
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	ft = { "nix", "lua", "tex" },
	after = function()
		vim.lsp.enable({ "nil_ls", "lua_ls", "texlab" })
	end
}
