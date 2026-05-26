-- [[ Configure LSP ]]
--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
-- Diagnostic Config
telescope = require("telescope.builtin")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end

		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
		map("gr", telescope.lsp_references, "[G]oto [R]eferences")
		map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
		map("gtd", telescope.lsp_type_definitions, "[G]oto [T]ype [D]efinition")
		map("gds", telescope.lsp_document_symbols, "[G]oto [D]ocument [S]ymbols")
		map("gws", telescope.lsp_dynamic_workspace_symbols, "[G]oto [W]orkspace [S]ymbols")

		if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Custom configs for servers that need non-default settings.
-- Servers with no custom config are enabled automatically by mason-lspconfig below.
vim.lsp.config("html", { filetypes = { "html", "twig", "hbs", "templ" } })
vim.lsp.config("cssls", { filetypes = { "scss", "css" } })
vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = { disableOrganizeImports = true },
		python = { analysis = { ignore = { "*" } } },
	},
})
vim.lsp.config("lua_ls", {
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				checkThirdParty = false,
				-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
				--  See https://github.com/neovim/nvim-lspconfig/issues/3189
				library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
					"${3rd}/luv/library",
					"${3rd}/busted/library",
				}),
			},
		})
	end,
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			format = { enable = false }, -- Disable formatting (formatting is done by stylua)
		},
	},
})

require("mason").setup({})

-- mason-lspconfig uses lspconfig server names and handles mason package name translation automatically.
-- To check the current status of installed tools and/or manually install other tools, run :Mason
-- You can press `g?` for help in this menu.
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "html", "cssls", "gopls", "rust_analyzer", "basedpyright", "lua_ls" },
	automatic_enable = true,
})

-- mason-tool-installer for tools that aren't LSP servers (formatters, linters, etc.)
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"ruff",
	},
})
