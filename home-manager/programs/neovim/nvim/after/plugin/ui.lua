local devicons = require("nvim-web-devicons")

devicons.setup({
	override_by_extension = {
		lua = {
			icon = "󰢱",
			color = "#7DCFFF",
			name = "Lua",
		},
		rs = {
			icon = "",
			color = "#ff9e64",
			name = "Rust",
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
			color = "#7BD88F",
			name = "Vim",
		},
		vue = {
			icon = "",
			color = "#249b73",
			name = "Vue",
		},
		nix = {
			icon = "",
			color = "#56aeff",
			name = "Nix",
		},
		ts = {
			icon = "󰛦",
			color = "#7aa2f7",
			name = "Typescript",
		},
		js = {
			icon = "",
			color = "#ffd12b",
			name = "Javascript",
		},
		["norg"] = {
			icon = "",
			--color = "#4878BE",
			color = "#7AA2F7",
			name = "Neorg",
		},
		["nuxt.config.ts"] = {
			icon = "󱄆",
			color = "#249b73",
			name = "Nuxt",
		},
	},
})

vim.cmd.packadd("lualine.nvim")

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

local barbecue = require("barbecue")
barbecue.setup({})

-- Indent colors
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
	bg = vim.api.nvim_get_hl(0, { name = "IblScope" }).bg,
	fg = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
})
-- BORDER GROUPS AND COLORS
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#7AA2F7" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#47517d" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#47517d" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#47517d" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "", fg = "#f7768e" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "", fg = "#7bd88f" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "", fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "", fg = "#ff9e64" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7AA2F7" })
