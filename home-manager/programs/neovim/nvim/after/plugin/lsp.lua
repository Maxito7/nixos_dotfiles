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
	capabilities = capabilities,
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
require("lspconfig").zls.setup({})
require("lspconfig").gleam.setup({
	cmd = { "glas", "--stdio" },
})
require("lspconfig").erlangls.setup({})
require("lspconfig").elixirls.setup({
	cmd = { "/nix/store/0bjsn9ypl449pnjlksxfykipkv1qp7yl-elixir-ls-0.20.0/lib/language_server.sh" },
})

-- Web-dev
require("lspconfig").svelte.setup({})
require("lspconfig").tsserver.setup({
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = nil
	end,
})
--[[
local result = vim.fn.systemlist("npm ls -g --depth=0")
local location = string.format("%s/node_modules/@vue/typescript-plugin", result[1])
if vim.fn.isdirectory(location) == 1 then
	-- Ensure @vue/typescript-plugin is installed
	-- before setting up tsserver
	require("lspconfig").tsserver.setup({
		on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = nil
		end,
		-- capabilities = capabilities,
		root_dir = require("lspconfig.util").root_pattern("src/App.vue", "nuxt.config.ts", "nuxt.config.js"),
		filetypes = { "vue", "typescript", "javascript", "json" },
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = location,
					languages = { "vue" },
				},
			},
		},
	})
else
	vim.api.nvim_err_writeln(
		"@vue/typescript-plugin is required, install globally via `npm install -g @vue/typescript-plugin`"
	)
end
require("lspconfig").volar.setup({
	init_options = {
		typescript = {
			tsdk = "/nix/store/nyj8q03sd2lyr6zn8qqaw43c7fhc8lcn-typescript-5.4.2/lib/node_modules/typescript/lib/",
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
})
]]

lsp.handlers["textdocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

-- bordered lsp diagnostics
vim.diagnostic.config({
	float = { border = "rounded" },
})
