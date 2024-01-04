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
