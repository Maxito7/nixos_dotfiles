require("nvim-web-devicons").refresh()

require("nvim-web-devicons").setup({
	default = true,
	color_icons = true,
	default_icon = {
		icon = "",
		name = "Default",
	},
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
	override_by_extension = {
		["norg"] = {
			icon = "",
			--color = "#4878BE",
			color = "#7AA2F7",
			name = "Neorg",
		},
	},
})

-- BORDER GROUPS AND COLORS
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#7AA2F7" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5f74a1" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#86a1db" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#3b4261" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "", fg = "#f7768e" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "", fg = "#7bd88f" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "", fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "", fg = "#ff9e64" })
