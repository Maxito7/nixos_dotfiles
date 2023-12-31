--[[
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
]]
--[[
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
]]

local config_path = vim.fn.stdpath("config")
local balls_path = vim.fs.joinpath(config_path, "pack", "balls", "start", "balls.nvim")

if vim.uv.fs_stat(balls_path) == nil then
  local command = {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/TheBallsUp/balls.nvim",
    balls_path,
  }

  vim.system(command, {}, vim.schedule_wrap(function(result)
    if result.code ~= 0 then
      error("Failed to install balls.nvim: " .. result.stderr)
    end

    vim.notify("Installed balls.nvim!")
    vim.cmd.packloadall()
    vim.cmd.helptags(vim.fs.joinpath(balls_path, "doc"))
  end))
end

local Balls = require("balls")

-- Setting up the PLUGINS
local plugins = {
	["nvim-tree/nvim-web-devicons"] = {},	
	["nvim-lualine/lualine.nvim"] = {
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}

for url, opts in pairs(plugins) do
	Balls:register("https://github.com/" .. url, opts)
end

-- Devicons

local devicons_installed, devicons = pcall(require, "nvim-web-devicons")

if not devicons_installed then
  return
end

devicons.setup({
	default = false,
		color_icons = true,
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
})

-- Lualine
local lualine_installed, lualine = pcall(require, "lualine")

if not lualine_installed then
  return
end

lualine.setup({
	options = {
		icons_enabled = true,
	},
})



--[[
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
]]
