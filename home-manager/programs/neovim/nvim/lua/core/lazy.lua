local config_path = vim.fn.stdpath("config")
local balls_path = vim.fs.joinpath(config_path, "pack", "balls", "start", "balls.nvim")

if vim.uv.fs_stat(balls_path) == nil then
  local command = {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/TheBallsUp/balls.nvim",
    balls_path,
  }

  vim.system(command, {}, vim.schedule_wrap(function(result)
    if result.code ~= 0 then
      error("Failed to install balls.nvim: " .. result.stderr)
    end

    vim.notify("Installed balls.nvim!")
    vim.cmd.packloadall()
    vim.cmd.helptags(vim.fs.joinpath(balls_path, "doc"))
  end))
end

local Balls = require("balls")

-- Setting up the PLUGINS
local plugins = {
	-- Devicons
	["nvim-tree/nvim-web-devicons"] = {},
	-- Barbecue + dependencies
	["SmiteshP/nvim-navic"] = {},
	["utilyre/barbecue.nvim"] = {
		lazy = true,
	},
	-- Lualine
	["nvim-lualine/lualine.nvim"] = {
		lazy = true,
	},
	-- Telescope + dependencies
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		on_sync = function(plugin)
			vim.system({ "make" }, { cwd = plugin:path() }, function(result)
				print("compiled fzf!")
			end)
		end,
	},
	["nvim-lua/plenary.nvim"] = {},
	["nvim-telescope/telescope.nvim"] = {
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = true,
	},
	-- Tokyonight
	["folke/tokyonight.nvim"] = {},
	-- Oil
	["stevearc/oil.nvim"] = {
		lazy = true,
	},
	-- LSP + dependencies
	["folke/neodev.nvim"] = {},
	["neovim/nvim-lspconfig"] = {
		event = { "BufReadPre", "BufNewFile" },
	},
	-- CMP + dependencies
	["hrsh7th/cmp-path"] = {},
	["hrsh7th/cmp-cmdline"] = {},
	["L3MON4D3/LuaSnip"] = {},
	["saadparwaiz1/cmp_luasnip"] = {},
	["hrsh7th/cmp-nvim-lsp"] = {},
	["rafamadriz/friendly-snippets"] = {},
	["onsails/lspkind.nvim"] = {},
	["hrsh7th/nvim-cmp"] = {},
	-- Autopairs
	["windwp/nvim-autopairs"] = {
		event = "InsertEnter",
	},
}

for url, opts in pairs(plugins) do
	Balls:register("https://github.com/" .. url, opts)
end

-- Tokyonight
local tokyonight = require("tokyonight")
tokyonight.setup({
	style = "night",
	transparent = true,
	on_colors = function(colors)
		colors.green = "#62d196"
		colors.comment = "#86a1db"
	end,
	styles = {
		floats = "transparent",
		sidebars = "transparent",
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
	end,
})

vim.cmd("colorscheme tokyonight")

-- Devicons
local devicons = require("nvim-web-devicons")

devicons.setup({
	default = false,
		color_icons = true,
		override = {
			rs = {
				icon = " ",
				color = "#ff9e64",
				name = "Rust",
			},
			lua = {
				icon = "󰢱",
				color = "#7DCFFF",
				name = "Lua",
			},
			py = {
				icon = "",
				color = "#7bd88f",
				name = "Python",
			},
			go = {
				icon = "",
				color = "#7dcfff",
				name = "Go",
			},
			cpp = {
				icon = "",
				color = "#7aa2f7",
				name = "CPP",
			},
			c = {
				icon = "",
				color = "#BB9AF7",
				name = "C",
			},
			tex = {
				icon = "",
				color = "#9AA5CE",
				name = "LaTeX",
			},
			vim = {
				icon = "",
				color = "#7BD88F",
				name = "Vim",
			},
			vue = {
				icon = "",
				color = "#7bd88f",
				name = "Vue",
			},
		},
		default_icon = {
			icon = "",
			name = "Default",
		},
		override_by_extension = {
			["norg"] = {
				icon = "",
				--color = "#4878BE",
				color = "#7AA2F7",
				name = "Neorg",
			},
		},
})

-- Lualine
vim.cmd.packadd("lualine.nvim")
local lualine = require("lualine")

lualine.setup({
	options = {
		icons_enabled = true,
	},
})

-- Telescope
vim.cmd.packadd("telescope")
local telescope = require("telescope")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				width = 0.8,
				preview_width = 0.5,
			},
			vertical = {
				width = 0.7,
				height = 0.9,
				preview_cutoff = 1,
				prompt_position = "top",
				preview_height = 0.4,
				mirror = true,
			},
		},
	},
})
telescope.load_extension("fzf")

-- Barbecue
vim.cmd.packadd("barbecue")
local barbecue = require("barbecue")
barbecue.setup({})

-- Oil
vim.cmd.packadd("oil")
local oil = require("oil")
oil.setup({
		default_file_explorer = true,
		columns = {
			"icon",
			--"permissions",
			--"size",
			--"mtime",
		},
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		delete_to_trash = false,
		skip_confirm_for_simple_edits = false,
		trash_command = "trash-put",
		prompt_save_on_select_new_entry = true,
		cleanup_delay_ms = 2000,
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
		},
		use_default_keymaps = true,
		view_options = {
			show_hidden = true,
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".")
			end,
			is_always_hidden = function(name, bufnr)
				return false
			end,
			sort = {
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},
		float = {
			padding = 2,
			max_width = 0,
			max_height = 0,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			override = function(conf)
				return conf
			end,
		},
		preview = {
			max_width = 0.9,
			min_width = { 40, 0.4 },
			width = nil,
			max_height = 0.9,
			min_height = { 5, 0.1 },
			height = nil,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
		progress = {
			max_width = 0.9,
			min_width = { 40, 0.4 },
			width = nil,
			max_height = { 10, 0.9 },
			min_height = { 5, 0.1 },
			height = nil,
			border = "rounded",
			minimized_border = "none",
			win_options = {
				winblend = 0,
			},
		},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

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

require("lspconfig").rnix.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").rust_analyzer.setup({})
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

lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

-- Bordered LSP Diagnostics
vim.diagnostic.config({
	float = { border = "rounded" },
})

-- Autopairs
local autopairs = require("nvim-autopairs")
autopairs.setup({})

-- CMP
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local max_items = 7

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	dependencies = {
		cmp_path,
	},
	completion = {
		completeopt = "menu,menuone,preview,noselect",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = {
		{ name = "nvim_lsp", max_item_count = max_items },
		{ name = "luasnip", max_item_count = max_items },
		{ name = "neorg", max_item_count = max_items },
		{ name = "path", max_item_count = max_items },
	},
	window = {
		completion = cmp.config.window.bordered({
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		}),
		documentation = cmp.config.window.bordered({
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		}),
		scrollbar = false,
	},
	-- configure lspkind for vs-code like pictograms in completion menu
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer", max_item_count = max_items },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path", max_item_count = max_items },
	}, {
		{ name = "cmdline", max_item_count = max_items },
	}),
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_auto = require("cmp")
cmp_auto.event:on("confirm_done", cmp_autopairs.on_confirm_done())
