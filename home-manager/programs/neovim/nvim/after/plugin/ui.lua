local devicons = require("nvim-web-devicons")

devicons.setup({
	override_by_extension = {
		lua = {
			icon = "󰢱",
			color = "#5e99ff",
			--color = "#003ab8",
			name = "Lua",
		},
		rs = {
			icon = "",
			color = "#ff9e64",
			--color = "#ff832b",
			name = "Rust",
		},
		rb = {
			icon = "",
			color = "#f7768e",
			name = "Ruby",
		},
		py = {
			icon = "",
			color = "#6fdc8c",
			name = "Python",
		},
		go = {
			icon = "",
			color = "#7dcfff",
			name = "Go",
		},
		cpp = {
			icon = "",
			color = "#5e99ff",
			name = "CPP",
		},
		c = {
			icon = "",
			color = "#BB9AF7",
			--color = "#6929c4",
			name = "C",
		},
		tex = {
			icon = "",
			color = "#c0caf5",
			name = "LaTeX",
		},
		md = {
			icon = "󰽛",
			color = "#c0caf5",
			name = "Markdown",
		},
		vim = {
			icon = "",
			color = "#6fdc8c",
			name = "Vim",
		},
		vue = {
			icon = "",
			color = "#289c5e",
			name = "Vue",
		},
		nix = {
			icon = "",
			color = "#33b1ff",
			name = "Nix",
		},
		ts = {
			icon = "󰛦",
			color = "#5e99ff",
			name = "Typescript",
		},
		js = {
			icon = "󰌞",
			color = "#ffd12b",
			name = "Javascript",
		},
		["norg"] = {
			icon = "",
			color = "#3692d5",
			name = "Neorg",
		},
		["nuxt.config.ts"] = {
			icon = "󱄆",
			color = "#289c5e",
			name = "Nuxt",
		},
		["Cargo.toml"] = {
			icon = "",
			color = "#ff9e64",
			name = "Cargo.toml",
		},
		["gleam"] = {
			icon = "",
			color = "#ff96f3",
			name = "Gleam",
		},
		["typ"] = {
			icon = "󰊄",
			color = "#6fdcbb",
			name = "Typst",
		},
	},
})

local barbecue = require("barbecue")
barbecue.setup({})

local lualine = require("lualine")

lualine.setup({
	opt = true,
	options = {
		icons_enabled = true,
	},
})

-- Oil
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

-- Indent colors
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
	bg = vim.api.nvim_get_hl(0, { name = "IblScope" }).bg,
	fg = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
})
-- BORDER GROUPS AND COLORS
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#5e99ff" })
--vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#4d5358" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#47517d" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#47517d" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#47517d" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "", fg = "#f7768e" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "", fg = "#62d196" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "", fg = "#5e99ff" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "", fg = "#ff9e64" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#5e99ff" })
