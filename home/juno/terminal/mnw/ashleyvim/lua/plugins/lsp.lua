return {
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	ft = { "nix", "lua", "tex" },
	after = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "nix",
			callback = function()
				vim.lsp.enable({ "nil_ls" })
			end
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "lua",
			callback = function()
				vim.lsp.enable({ "lua_ls" })
			end
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				vim.lsp.enable({ "texlab" })
			end
		})
	end
}
