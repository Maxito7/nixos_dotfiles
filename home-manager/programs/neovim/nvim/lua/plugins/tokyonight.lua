return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
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
	},
}
