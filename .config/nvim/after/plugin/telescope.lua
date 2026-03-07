pcall(require("telescope").load_extension, "fzf")

require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--color", "never", "--no-require-git" },
		},
	},
})

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})
	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

local tb = require("telescope.builtin")
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", tb.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", tb.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	tb.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("v", "<leader>/", function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, { desc = "[/] Search by grep selected text" })

vim.keymap.set("n", "<leader>gf", tb.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", tb.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", tb.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", tb.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", tb.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", tb.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", tb.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>swf", function()
	-- For this function to work ripgrep had to be installed.
	tb.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[S]earch [W]ord in [F]ile" })
