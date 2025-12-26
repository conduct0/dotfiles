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

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

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
