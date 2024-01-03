print("I AM INSIDE OF TH AFTER-CALL")

local devicons = require("nvim-web-devicons")

devicons.setup({
	override_by_extension = {
		lua = {
			icon = "P",
			color = "#7DCFFF",
			name = "Lua",
		},
		rs = {
			icon = " ",
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
		["norg"] = {
			icon = "",
			--color = "#4878BE",
			color = "#7AA2F7",
			name = "Neorg",
		},
	},
})

vim.cmd.packadd("lualine.nvim")

local lualine = require("lualine")

lualine.setup({
	options = {
		icons_enabled = true,
	},
})
