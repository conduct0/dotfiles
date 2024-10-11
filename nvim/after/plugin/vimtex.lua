vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_format_enabled = 1
vim.g.vimtex_compiler_latexmk = {
	options = {
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-shell-escape",
	},
}
