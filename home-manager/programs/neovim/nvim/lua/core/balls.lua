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

	vim.system(
		command,
		{},
		vim.schedule_wrap(function(result)
			if result.code ~= 0 then
				error("Failed to install balls.nvim: " .. result.stderr)
			end

			vim.notify("Installed balls.nvim!")
			vim.cmd.packloadall()
			vim.cmd.helptags(vim.fs.joinpath(balls_path, "doc"))
		end)
	)
end

local Balls = require("balls")

--[[                                                                         
    _/_/_/    _/        _/    _/    _/_/_/  _/_/_/  _/      _/    _/_/_/   
   _/    _/  _/        _/    _/  _/          _/    _/_/    _/  _/          
  _/_/_/    _/        _/    _/  _/  _/_/    _/    _/  _/  _/    _/_/       
 _/        _/        _/    _/  _/    _/    _/    _/    _/_/        _/      
_/        _/_/_/_/    _/_/      _/_/_/  _/_/_/  _/      _/  _/_/_/         
]]

local plugins = {
	-- Devicons
	["nvim-tree/nvim-web-devicons"] = {
		lazy = false,
	},
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
	-- Treesitter + dependencies
	["JoosepAlviste/nvim-ts-context-commentstring"] = {
		opts = {
			enable_autocmd = false,
		},
	},
	["windwp/nvim-ts-autotag"] = {},
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		event = { "BufRead", "BufNewFile" },
	},
	["nvim-treesitter/nvim-treesitter"] = {
		cmd = { "TSInstall", "TSUpdate" },
		event = { "BufRead", "BufNewFile" },
		build = function()
			vim.cmd("TSUpdate")
		end,
	},
	-- No-neck-pain
	["shortcuts/no-neck-pain.nvim"] = {},
	-- Colorizer
	["NvChad/nvim-colorizer.lua"] = {},
	-- Indent Blankline (indent-blankline + mini.indent)
	["lukas-reineke/indent-blankline.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
	},
	["echasnovski/mini.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
	},
	["stevearc/conform.nvim"] = {
		event = "BufReadPre",
	},
}

for url, opts in pairs(plugins) do
	Balls:register("https://github.com/" .. url, opts)
end

--[[
 ________  ________  ________   ________ ___  ________  ________      
|\   ____\|\   __  \|\   ___  \|\  _____\\  \|\   ____\|\   ____\     
\ \  \___|\ \  \|\  \ \  \\ \  \ \  \__/\ \  \ \  \___|\ \  \___|_    
 \ \  \    \ \  \\\  \ \  \\ \  \ \   __\\ \  \ \  \  __\ \_____  \   
  \ \  \____\ \  \\\  \ \  \\ \  \ \  \_| \ \  \ \  \|\  \|____|\  \  
   \ \_______\ \_______\ \__\\ \__\ \__\   \ \__\ \_______\____\_\  \ 
    \|_______|\|_______|\|__| \|__|\|__|    \|__|\|_______|\_________\
                                                          \|_________|
]]

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

-- Lualine
vim.cmd.packadd("lualine.nvim")
local lualine = require("lualine")

lualine.setup({
	options = {
		icons_enabled = true,
	},
})

-- Telescope
vim.cmd.packadd("telescope.nvim")
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
vim.cmd.packadd("barbecue.nvim")
local barbecue = require("barbecue")
barbecue.setup({})

-- Oil
vim.cmd.packadd("oil.nvim")
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

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"astro",
		"bash",
		"bibtex",
		"c",
		"cpp",
		"css",
		"gitcommit",
		"gitignore",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		-- "latex",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"php",
		"python",
		"query",
		"regex",
		"rust",
		"sql",
		--"ssh_config",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown " },
	},
	indent = { enable = true },
	-- context_commentstring = {
	--   enable = true,
	--   enable_autocmd = false,
	-- },
	autotag = { enable = true },
	autopairs = { enable = true },
	use = {
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers", -- This is the important bit!
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
				},
			})
		end,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = { query = "@function.outer", desc = "Around the function" },
				["if"] = { query = "@function.inner", desc = "Inside the function" },
				["ac"] = { query = "@class.outer", desc = "Around the class" },
				["ic"] = { query = "@class.inner", desc = "Inside the class" },
				["aI"] = { query = "@conditional.outer", desc = "Around the conditional" },
				["iI"] = { query = "@conditional.inner", desc = "Inside the conditional" },
				["aL"] = { query = "@loop.outer", desc = "Around the loop" },
				["iL"] = { query = "@loop.inner", desc = "Inside the loop" },
				["aC"] = { query = "@comment.outer", desc = "Around the comment" },
				["iC"] = { query = "@comment.inner", desc = "Inside the comment" },
				["as"] = { query = "@scope", desc = "Language scope" },
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = { query = "@function.*", desc = "Next function start" },
				["]c"] = { query = "@class.*", desc = "Next class start" },

				-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				["]l"] = { query = "@loop.*", desc = "Go to next loop part" },
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
			},
			goto_next = {
				["]I"] = "@conditional.outer",
			},
			goto_previous = {
				["[I"] = "@conditional.outer",
			},
		},
	},
})

-- NNP
local NoNeckPain = require("no-neck-pain")
require("no-neck-pain").setup({
	width = 140,
	autocmds = {
		enableOnVimEnter = true,
		enableOnTabEnter = true,
	},
	buffers = {
		setNames = false,
		wo = {
			fillchars = "eob: ",
		},
		left = NoNeckPain.bufferOptions,
		right = NoNeckPain.bufferOptions,
	},
})

NoNeckPain.bufferOptions = {
	enabled = false,
	colors = NoNeckPain.bufferOptionsColors,
	--- @see NoNeckPain.bufferOptionsBo `:h NoNeckPain.bufferOptionsBo`
	bo = NoNeckPain.bufferOptionsBo,
	--- @see NoNeckPain.bufferOptionsWo `:h NoNeckPain.bufferOptionsWo`
	wo = NoNeckPain.bufferOptionsWo,
}

NoNeckPain.bufferOptionsWo = {
	--- @type boolean
	cursorline = false,
	--- @type boolean
	cursorcolumn = false,
	--- @type string
	colorcolumn = "0",
	--- @type boolean
	number = false,
	--- @type boolean
	relativenumber = false,
	--- @type boolean
	foldenable = false,
	--- @type boolean
	list = false,
	--- @type boolean
	wrap = true,
	--- @type boolean
	linebreak = true,
}

NoNeckPain.bufferOptionsBo = {
	--- @type string
	filetype = "no-neck-pain",
	--- @type string
	buftype = "nofile",
	--- @type string
	bufhidden = "hide",
	--- @type boolean
	buflisted = false,
	--- @type boolean
	swapfile = false,
}

-- Indent blanklines
require("ibl").setup({
	indent = {
		char = "│",
		tab_char = "│",
	},
	scope = { enabled = false },
	exclude = {
		filetypes = {
			"help",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"toggleterm",
		},
	},
})
require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
	draw = {
		delay = 0,
		animation = require("mini.indentscope").gen_animation.none(),
	},
})
-- Indent colors
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
	bg = vim.api.nvim_get_hl(0, { name = "IblScope" }).bg,
	fg = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"neo-tree",
		"Trouble",
		"trouble",
		"lazy",
		"mason",
		"toggleterm",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

-- Colorizer
require("colorizer").setup({})

-- Conform setup
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "ruff" },
		go = { "gofumpt" },
		-- Use a sub-list to run only the first available formatter
		--javascript = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 6000,
		lsp_fallback = true,
	},
})

-- mini.animate
require("mini.animate").setup({
	resize = {
		enable = false,
	},
	open = {
		enable = false,
	},
	close = {
		enable = false,
	},
})

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
