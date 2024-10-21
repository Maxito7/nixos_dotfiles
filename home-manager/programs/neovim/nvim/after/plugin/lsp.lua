-- LSP
local lsp = vim.lsp

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)

	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)

	bufmap("gr", require("telescope.builtin").lsp_references)
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

	bufmap("<leader>h", vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local util = require("lspconfig/util")

require("neodev").setup()
require("lspconfig").lua_ls.setup({
	event = { "BufReadPre", "BufNewFile" },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
					vim.fn.stdpath("config") .. "/lua",
				},
				checkThirdParty = false,
			},
		},
	},
})
require("lspconfig").ruff_lsp.setup({
	on_attach = on_attach,
	init_options = {
		settings = {
			-- Any extra CLI arguments for `ruff` go here.
			args = {},
		},
	},
})
require("lspconfig").jedi_language_server.setup({
	init_options = {
		codeAction = {
			nameExtractVariable = "jls_extract_var",
			nameExtractFunction = "jls_extract_def",
		},
		completion = {
			disableSnippets = false,
			resolveEagerly = false,
			ignorePatterns = {},
		},
		diagnostics = {
			enable = true,
			didOpen = true,
			didChange = true,
			didSave = true,
		},
		hover = {
			enable = true,
			disable = {
				class = { all = false, names = {}, fullNames = {} },
				["function"] = { all = false, names = {}, fullNames = {} },
				instance = { all = false, names = {}, fullNames = {} },
				keyword = { all = false, names = {}, fullNames = {} },
				module = { all = false, names = {}, fullNames = {} },
				param = { all = false, names = {}, fullNames = {} },
				path = { all = false, names = {}, fullNames = {} },
				property = { all = false, names = {}, fullNames = {} },
				statement = { all = false, names = {}, fullNames = {} },
			},
		},
		jediSettings = {
			autoImportModules = {},
			caseInsensitiveCompletion = true,
			debug = false,
		},
		markupKindPreferred = "markdown",
		workspace = {
			extraPaths = {},
			symbols = {
				ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
				maxSymbols = 20,
			},
		},
	},
})
require("lspconfig").slint_lsp.setup({
	filetypes = { "slint" },
})
--[[
require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust_analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				features = "all",
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
			checkOnSave = true,
			check = {
				command = "clippy",
				features = "all",
				invocationLocation = "workspace",
				extraArgs = {
					"--",
					"--tests",
					"--no-deps",
					"-Dclippy::correctness",
					"-Dclippy::complexity",
					"-Wclippy::perf",
					"-Wclippy::pedantic",
				},
			},
			files = {
				excludeDirs = { ".direnv" },
			},
		},
	},
})
]]

require("lspconfig").clangd.setup({})
require("lspconfig").nil_ls.setup({})
require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
			workspaceFolders = true,
		},
	},
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})
vim.filetype.add({ extension = { templ = "templ" } })
require("lspconfig").templ.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").htmx.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "templ" },
})
require("lspconfig").zls.setup({})
require("lspconfig").gleam.setup({
	cmd = { "glas", "--stdio" },
})
--[[
require("lspconfig").erlangls.setup({})
require("lspconfig").elixirls.setup({
	cmd = { "/nix/store/0bjsn9ypl449pnjlksxfykipkv1qp7yl-elixir-ls-0.20.0/lib/language_server.sh" },
})
]]
-- Typst
--[[
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.typ" },
	callback = function()
		vim.opt.filetype = "typst"
	end,
})
]]
vim.filetype.add({ extension = { typ = "typst" } })
require("lspconfig").tinymist.setup({
	capabilities = capabilities,
	root_dir = function(filename, bufnr)
		return vim.fn.getcwd()
	end,
	settings = {
		exportPdf = "onSave",
		systemFonts = true,
		formatterMode = "typstyle",
	},
})
-- pin the main file
vim.lsp.buf.execute_command({ command = "tinymist.pinMain", arguments = { vim.api.nvim_buf_get_name(0) } })
-- unpin the main file
vim.lsp.buf.execute_command({ command = "tinymist.pinMain", arguments = { nil } })

-- Web-dev
require("lspconfig").svelte.setup({})
-- Volar
require("lspconfig").ts_ls.setup({
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = nil
	end,
})

lsp.handlers["textdocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

-- bordered lsp diagnostics
vim.diagnostic.config({
	float = { border = "rounded" },
})
