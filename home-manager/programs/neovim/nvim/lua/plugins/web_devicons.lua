return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		-- Web-Devicons
		require("nvim-web-devicons").setup({
			default = false,
			color_icons = false,
			default_icon = {
				icon = "",
				name = "Default",
			},
			override = {
				rs = {
					icon = "",
					color = "#ff9e64",
					name = "Rs",
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
			strict = true,
			override_by_extension = {
				["norg"] = {
					icon = "",
					color = "#4878BE",
					name = "Neorg",
				},
			},
		})
	end,
}
