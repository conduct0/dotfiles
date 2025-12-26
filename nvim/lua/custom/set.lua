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

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
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
--  Show date with file in Netwr
vim.g.netrw_liststyle = 0
vim.g.netrw_timefmt = "%a %d/%m/%y  %H:%M:%S"
vim.g.netrw_sizestyle = "H"

-- Spell checker
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- VimTex
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

-- Markdown Todo

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		local opts = { buffer = true, silent = true }

		vim.keymap.set("n", "<leader>tt", function()
			local line = vim.api.nvim_get_current_line()
			local new_line
			if line:match("^%s*- %[ %]") then
				-- Empty -> Checked
				new_line = line:gsub("^(%s*- )%[ %]", "%1[x]")
			elseif line:match("^%s*- %[x%]") then
				-- Checked -> Empty
				new_line = line:gsub("^(%s*- )%[x%]", "%1[ ]")
			else
				local indent = line:match("^%s*") or ""
				local content = line:gsub("^%s*", "")
				if content == "" then
					new_line = indent .. "- [ ] "
				else
					new_line = indent .. "- [ ] " .. content
				end
			end
			vim.api.nvim_set_current_line(new_line)
		end, vim.tbl_extend("force", opts, { desc = "Toggle todo checkbox" }))
	end,
})
