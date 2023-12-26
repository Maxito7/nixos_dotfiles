return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {},

			auto_install = false,

			highlight = { enable = true },

			indent = { enable = true },

			use = {
				"nvim-neorg/neorg",
				run = ":Neorg sync-parsers", -- This is the important bit!
				config = function()
					require("neorg").setup({
						load = {
							["core.defaults"] = {},
							["core.concealer"] = {},
							["core.completion"] = {
								config = {
									engine = "nvim-cmp",
								},
							},
						},
					})
				end,
			},
		})
	end,
}
