return {
	"nvim-tree/nvim-web-devicons",
	--lazy = true,
	--event = "VeryLazy",
	--priority = 2000,
	opts = {
		override = {
			rs = {
				icon = " ",
				color = "#ff9e64",
				name = "Rust",
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
		default = false,
		color_icons = true,
		default_icon = {
			icon = "",
			name = "Default",
		},
		override_by_extension = {
			["norg"] = {
				icon = "",
				--color = "#4878BE",
				color = "#7AA2F7",
				name = "Neorg",
			},
		},
	},
	config = function(_, opts) --(_, opts)
		require("nvim-web-devicons").setup(opts)
	end,
}
