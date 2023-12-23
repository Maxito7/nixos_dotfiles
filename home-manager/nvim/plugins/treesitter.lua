require('nvim-treesitter.configs').setup {
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
					},
				})
			end,
		},
}
