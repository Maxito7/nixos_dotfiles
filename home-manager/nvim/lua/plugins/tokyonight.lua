return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
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
	end,
}
