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
