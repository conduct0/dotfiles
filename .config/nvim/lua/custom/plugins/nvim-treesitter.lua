return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	autotag = { enable = true },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
