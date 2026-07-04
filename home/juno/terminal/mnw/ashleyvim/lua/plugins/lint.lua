return {
	"lint.nvim",
	ft = { "nix" },
	after = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			nix = { 'statix' },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end
}
