vim.g.mapleader = " "

-- When Highlighted can move up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Select all
vim.keymap.set("n", "<C-l>", "ggVG", { desc = "Select all lines" })

-- Take line under and paste on curr line with space
vim.keymap.set("n", "J", "mzJ`z")

-- half page jumping with cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz0")
vim.keymap.set("n", "<C-u>", "<C-u>zz0")

-- search term stays in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over a word, deleting it, without loosing yanked
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over, no yank" })

-- Copy to system clipboard
vim.keymap.set("v", "<leader>y", [["+y]], { desc = "Yank selection to clip" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank curr line to clip" })
-- Replace current word
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace current word" }
)
vim.keymap.set("v", "<C-r>", [["hy:%s/<C-r>h//gc<left><left><left>]], { desc = "Replace selected text" })



        
-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Oil
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Utils
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Esc" })
vim.keymap.set("n", "<A-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<A-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Markview
vim.keymap.set("n", "<leader>m", "<cmd>Markview toggle<CR>", { desc = "Toggle Markdown preview" })
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
