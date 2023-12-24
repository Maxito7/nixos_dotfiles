-- Web-Devicons
require("nvim-web-devicons").setup({
	default = false,
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
	color_icons = true,
})

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

require("mini.animate").setup()
