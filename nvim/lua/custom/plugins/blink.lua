return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"folke/lazydev.nvim",
	},
	config = function()
		require("blink.cmp").setup({
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				list = {
					selection = { auto_insert = true },
				},
			},

			sources = {
				default = { "lsp", "buffer", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		})

		local ls = require("luasnip")
		ls.filetype_extend("javascriptreact", { "html" })
		ls.filetype_extend("typescriptreact", { "html" })
		ls.filetype_extend("jsx", { "html" })
		ls.filetype_extend("tsx", { "html" })
	end,
}
