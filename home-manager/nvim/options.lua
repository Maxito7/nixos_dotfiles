vim.g.mapleader = " "

vim.o.clipboard = "unnamedplus"

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = "yes"

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = "a"

vim.opt.laststatus = 3

--[[
======================================================

██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝

=======================================================
]]

-- DEL. THE COMMENTED CODE HERE IF NTH. WORKS! I DON'T KNOW WHAT THE FUCK I'M DOING! :D
-- Lualine
require("lualine").setup({
	icons_enabled = true,
	--theme = 'onedark',
})

-- Tokyonight
require("tokyonight").setup({
	style = "night",
	transparent = true,
	terminal_colors = true,
	on_colors = function(colors)
		colors.green = "#7BD88F"
		colors.comment = "#86a1db"
		--colors.bg_dark = "#7aabdf"
		--colors.fg_gutter = "#4d5b78"
	end,
	styles = {
		floats = "transparent",
		sidebars = "transparent",
	},
})
-- Setting up Tokyonight
vim.cmd("colorscheme tokyonight")

-- BORDER GROUPS AND COLORS
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#7AA2F7" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5f74a1" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#86a1db" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#3b4261" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "", fg = "#f7768e" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "", fg = "#7bd88f" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "", fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "", fg = "#ff9e64" })

-- Barbecue
require("barbecue").setup({})

-- Bordered LSP Diagnostics
vim.diagnostic.config({
	float = { border = "rounded" },
})

-- Colorizer
--require("colorizer").setup({})

-- Autopairs
require("nvim-autopairs").setup({})

local NoNeckPain = require("no-neck-pain")
-- NoNeckPain config
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

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

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

-- cmp.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})
local lspkind = require("lspkind")
local cmp_path = require("cmp_path")

cmp.setup({
	dependencies = {
		cmp_path,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "neorg" },
		{ name = "path" },
	},
	window = {
		completion = cmp.config.window.bordered({
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		}),
		documentation = cmp.config.window.bordered({
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		}),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_auto = require("cmp")
cmp_auto.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- conform.lua
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

-- image.lua
require("image").setup({
	backend = "kitty",
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
		},
		neorg = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			filetypes = { "norg" },
		},
	},
	max_width = nil,
	max_height = nil,
	max_width_window_percentage = nil,
	max_height_window_percentage = 50,
	window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
})

-- lsp.lua
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

-- neorg.lua
require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
				default_workspace = "notes",
			},
		},
	},
})

-- oil.lua
-- Oil setup
require("oil").setup({
	-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
	-- Set to false if you still want to use netrw.
	default_file_explorer = true,
	-- Id is automatically added at the beginning, and name at the end
	-- See :help oil-columns
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	-- Buffer-local options to use for oil buffers
	buf_options = {
		buflisted = false,
		bufhidden = "hide",
	},
	-- Window-local options to use for oil buffers
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
	-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
	delete_to_trash = false,
	-- Skip the confirmation popup for simple operations
	skip_confirm_for_simple_edits = false,
	-- Change this to customize the command used when deleting to trash
	trash_command = "trash-put",
	-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
	prompt_save_on_select_new_entry = true,
	-- Oil will automatically delete hidden buffers after this delay
	-- You can set the delay to false to disable cleanup entirely
	-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
	cleanup_delay_ms = 2000,
	-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
	-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
	-- Additionally, if it is a string that matches "actions.<name>",
	-- it will use the mapping at require("oil.actions").<name>
	-- Set to `false` to remove a keymap
	-- See :help oil-actions for a list of all available actions
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
	-- Set to false to disable all of the above keymaps
	use_default_keymaps = true,
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
		-- This function defines what is considered a "hidden" file
		is_hidden_file = function(name, bufnr)
			return vim.startswith(name, ".")
		end,
		-- This function defines what will never be shown, even when `show_hidden` is set
		is_always_hidden = function(name, bufnr)
			return false
		end,
		sort = {
			-- sort order can be "asc" or "desc"
			-- see :help oil-columns to see which columns are sortable
			{ "type", "asc" },
			{ "name", "asc" },
		},
	},
	-- Configuration for the floating window in oil.open_float
	float = {
		-- Padding around the floating window
		padding = 2,
		max_width = 0,
		max_height = 0,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		-- This is the config that will be passed to nvim_open_win.
		-- Change values here to customize the layout
		override = function(conf)
			return conf
		end,
	},
	-- Configuration for the actions floating preview window
	preview = {
		-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_width and max_width can be a single value or a list of mixed integer/float types.
		-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
		max_width = 0.9,
		-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
		min_width = { 40, 0.4 },
		-- optionally define an integer/float for the exact width of the preview window
		width = nil,
		-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_height and max_height can be a single value or a list of mixed integer/float types.
		-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
		max_height = 0.9,
		-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
		min_height = { 5, 0.1 },
		-- optionally define an integer/float for the exact height of the preview window
		height = nil,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
	},
	-- Configuration for the floating progress window
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

-- telescope.lua
require("telescope").setup({
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

require("telescope").load_extension("fzf")

-- treesitter.lua
require("nvim-treesitter.configs").setup({
	ensure_installed = {},

	auto_install = false,

	highlight = { enable = true },

	indent = { enable = true },

	use = {
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers", -- This is the important bit!
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
				},
			})
		end,
	},
})

-- Web-Devicons
require("nvim-web-devicons").setup({
	color_icons = true,
	strict = true,
	override = {
		rs = {
			icon = "",
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
	override_by_extension = {
		["norg"] = {
			icon = "",
			color = "#4878BE",
			name = "Neorg",
		},
		["py"] = {
			icon = "",
			color = "#7bd88f",
			name = "Python",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
})

require("nvim-web-devicons").refresh()
