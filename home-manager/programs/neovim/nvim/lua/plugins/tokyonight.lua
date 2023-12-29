return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		transparent = true,
		on_colors = function(colors)
			--colors.green = "#7BD88F"
			--colors.green = "#95ffa4"
			colors.green = "#62d196"
			colors.comment = "#86a1db"
			--colors.bg_dark = "#7aabdf"
			--colors.fg_gutter = "#4d5b78"
		end,
		styles = {
			floats = "transparent",
			sidebars = "transparent",
		},
	},
	config = function(_, opts) --(_, opts)
		--local tokyonight = require("tokyonight")
		--require("lualine").setup(opts)
		require("tokyonight").setup(opts)
		--tokyonight.setup(opts)
		--tokyonight.load()
		--require("tokyonight").load()
		vim.cmd("colorscheme tokyonight")
	end,
}
