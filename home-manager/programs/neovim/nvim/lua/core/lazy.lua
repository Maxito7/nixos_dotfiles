-- Bootstrap Lazy Vim plugin manager
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

local lazy = require("lazy")

local plugins = {	
	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		version = "*",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.lualine").setup,
	},
	-- Oil
	{
		"stevearc/oil.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.oil").setup,
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
	},
	-- Dev icons
	{
		"nvim-tree/nvim-web-devicons",
		version = "*",
		config = require("plugins.devicons").setup,
	},
}

local options = {
	defaults = {
		lazy = false,
		version = "*",
	},
	dev = {
		path = "~/.local/share/nvim/nix",
		fallback = false,
	},
	lockfile = "~/.config/nvim/lazy-lock.json",
}

lazy.setup(plugins, options)
