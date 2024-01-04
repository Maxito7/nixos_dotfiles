vim.cmd.packadd("tokyonight.nvim")
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
