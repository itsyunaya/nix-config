return {
	"nvim-cmp",
	event = { "InsertEnter", "BufReadPre" },
	after = function()
		local cmp = require("cmp")

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "luasnip", priority = 1000 },
				{ name = "nvim_lsp", priority = 750 },
				{ name = "vimtex", priority = 500 },
				{ name = "path", priority = 250 },
				{ name = "buffer", priority = 250 },
			}),

			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

				["<Tab>"] = cmp.mapping(function(fallback)
					local ls = require("luasnip")
					if cmp.visible() then
						cmp.select_next_item()
					elseif ls.expand_or_jumpable() then
						ls.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					local ls = require("luasnip")
					if cmp.visible() then
						cmp.select_prev_item()
					elseif ls.jumpable(-1) then
						ls.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end
}