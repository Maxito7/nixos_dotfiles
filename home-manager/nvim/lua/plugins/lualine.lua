return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
