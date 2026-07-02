require("luasnip").setup({
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
})

local current_dir = string.sub(debug.getinfo(1).source, 2, -1):match("(.*/)")

require("luasnip.loaders.from_lua").lazy_load({
	paths = { current_dir .. "snippets" }
})