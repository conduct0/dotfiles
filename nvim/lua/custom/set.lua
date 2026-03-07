vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 1000

-- Show which line your cursor is on
vim.o.cursorline = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--  Show date with file in Netwr
vim.g.netrw_liststyle = 0
vim.g.netrw_timefmt = "%a %d/%m/%y  %H:%M:%S"
vim.g.netrw_sizestyle = "H"

-- Spell checker
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- VimTex and markdown should wrap text
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2

local group = vim.api.nvim_create_augroup("TexTWrapGroup", { clear = true })

local setWrappedText = function()
	vim.opt_local.wrap = true
	vim.opt_local.linebreak = true
end
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.tex", "*.md" },
	group = group,
	callback = setWrappedText,
})
--
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
