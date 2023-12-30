return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		transparent = true,
		on_colors = function(colors)
			--colors.green = "#7BD88F"
			colors.green = "#62d196"
			--colors.green1 = "#95ffa4"
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
		require("tokyonight").setup(opts)
		vim.cmd("colorscheme tokyonight")
	end,
}
