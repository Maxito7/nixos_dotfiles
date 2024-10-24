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
		name = "barbecue",
		version = "*",
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
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"folke/neodev.nvim",
		},
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
	},
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
	-- Conform
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
	},
	-- Img-clip
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
	-- Neorg.nvim
	--[[
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
		-- tag = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			})
		end,
	},
	]]
	-- Indent
	{
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("hlchunk").setup({
				line_num = {
					enable = false,
					style = "#5e99FF",
				},
				chunk = {
					style = "#5e99ff",
				},
				blank = {
					enable = false,
				},
			})
		end,
	},
	-- Vimtex
	{
		"lervag/vimtex",
		init = function() end,
	},
	-- Rustacean
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},
	-- Typst
	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
	},
	-- Slint
	{
		"slint-ui/vim-slint",
		ft = "slint",
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		main = "render-markdown",
		opts = {},
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	-- todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufNewFile", "BufReadPost" },
		keys = {
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment (Todo)",
			},
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment (Todo)",
			},
			{
				"<leader>xt",
				function()
					vim.cmd.Trouble("todo toggle focus=true filter = {tag = {FIX,TODO,HACK,WARN}}")
				end,
				desc = "Todo actionable comments (Trouble)",
			},
			{
				"<leader>xT",
				function()
					vim.cmd.Trouble("todo toggle focus=true")
				end,
				desc = "Todo all comments (Trouble)",
			},
		},
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- trouble.nvim
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		-- lazygit.nvim
		{
			"kdheepak/lazygit.nvim",
			-- lazy = true,
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			-- optional for floating window border decoration
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			-- setting the keybinding for LazyGit with 'keys' is recommended in
			-- order to load the plugin when the command is run for the first time
			keys = {
				{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			},
		},
	},
	-- yazi.nvim
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		-- event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
})
