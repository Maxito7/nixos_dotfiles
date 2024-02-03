vim.cmd.packadd("tokyonight.nvim")
local tokyonight = require("tokyonight")
tokyonight.setup({
	style = "night",
	transparent = true,
	on_colors = function(colors)
		colors.green = "#62d196"
		colors.comment = "#86a1db"
		colors.gitSigns = {
			add = "#7bd88f",
			change = "#7dcfff",
			delte = "#f7768e",
		}
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
