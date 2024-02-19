local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- Devicons
	"nvim-tree/nvim-web-devicons",
	-- Barbecue + dependencies
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
	},
	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		opt = true,
	},
	-- Telescope + dependencies
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		on_sync = function(plugin)
			vim.system({ "make" }, { cwd = plugin:path() }, function(result)
				print("compiled fzf!")
			end)
		end,
	},
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
	},
	-- Tokyonight
	"folke/tokyonight.nvim",
	-- Oil
	"stevearc/oil.nvim",
	-- LSP + dependencies
	"folke/neodev.nvim",
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
	},
	-- CMP + dependencies
		{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
	}
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	-- Treesitter + dependencies
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	"windwp/nvim-ts-autotag",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSInstall", "TSUpdate" },
		event = { "BufRead", "BufNewFile" },
		build = function()
			vim.cmd("TSUpdate")
		end,
	},
	-- No-neck-pain
	"shortcuts/no-neck-pain.nvim",
	-- Colorizer
	"NvChad/nvim-colorizer.lua",
	-- Indent Blankline (indent-blankline + mini.indent)
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"echasnovski/mini.nvim",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		opts = {},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
		},
	},
	-- Arrow.nvim
	"otavioschwanck/arrow.nvim",
})
