function vim.system(cmd, opts, on_exit)
	if type(opts) == "function" then
		on_exit = opts
		opts = nil
	end
	return require("vim.n_system").run(cmd, opts, on_exit)
end

-- Gets process info from the `ps` command.
-- Used by nvim_get_proc() as a fallback.
function vim._os_proc_info(pid)
	if pid == nil or pid <= 0 or type(pid) ~= "number" then
		error("invalid pid")
	end
	local cmd = { "ps", "-p", pid, "-o", "comm=" }
	local r = vim.system(cmd):wait()
	local name = assert(r.stdout)
	if r.code == 1 and vim.trim(name) == "" then
		return {} -- Process not found.
	elseif r.code ~= 0 then
		error("command failed: " .. vim.fn.string(cmd))
	end
	local ppid_string = assert(vim.system({ "ps", "-p", pid, "-o", "ppid=" }):wait().stdout)
	-- Remove trailing whitespace.
	name = vim.trim(name):gsub("^.*/", "")
	local ppid = tonumber(ppid_string) or -1
	return {
		name = name,
		pid = pid,
		ppid = ppid,
	}
end

---@param ... string
---@return string
---@class vim.system
function vim.system.joinpath(...)
	return (table.concat({ ... }, "/"):gsub("//+", "/"))
end

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

	vim.system(
		command,
		{},
		vim.schedule_wrap(function(result)
			if result.code ~= 0 then
				error("Failed to install balls.nvim: " .. result.stderr)
			end

			vim.notify("Installed balls.nvim!")
			vim.cmd.packloadall()
			vim.cmd.helptags(vim.fs.joinpath(balls_path, "doc"))
		end)
	)
end

local Balls = require("balls")

local plugins = {
	-- Devicons
	["nvim-tree/nvim-web-devicons"] = {},
	-- Barbecue + dependencies
	["SmiteshP/nvim-navic"] = {},
	["utilyre/barbecue.nvim"] = {},
	-- Lualine
	["nvim-lualine/lualine.nvim"] = {
		lazy = true,
		opt = true,
	},
	-- Telescope + dependencies
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		on_sync = function(plugin)
			vim.system({ "make" }, { cwd = plugin:path() }, function(result)
				print("compiled fzf!")
			end)
		end,
	},
	["nvim-lua/plenary.nvim"] = {},
	["nvim-telescope/telescope.nvim"] = {
		cmd = "Telescope",
	},
	-- Tokyonight
	["folke/tokyonight.nvim"] = {},
	-- Oil
	["stevearc/oil.nvim"] = {},
	-- LSP + dependencies
	["folke/neodev.nvim"] = {},
	["neovim/nvim-lspconfig"] = {
		event = { "BufReadPre", "BufNewFile" },
	},
	-- CMP + dependencies
	["hrsh7th/cmp-path"] = {},
	["hrsh7th/cmp-cmdline"] = {},
	["L3MON4D3/LuaSnip"] = {},
	["saadparwaiz1/cmp_luasnip"] = {},
	["hrsh7th/cmp-nvim-lsp"] = {},
	["rafamadriz/friendly-snippets"] = {},
	["onsails/lspkind.nvim"] = {},
	["hrsh7th/nvim-cmp"] = {},
	-- Autopairs
	["windwp/nvim-autopairs"] = {
		event = "InsertEnter",
	},
	-- Treesitter + dependencies
	["JoosepAlviste/nvim-ts-context-commentstring"] = {
		opts = {
			enable_autocmd = false,
		},
	},
	["windwp/nvim-ts-autotag"] = {},
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		event = { "BufRead", "BufNewFile" },
	},
	["nvim-treesitter/nvim-treesitter"] = {
		cmd = { "TSInstall", "TSUpdate" },
		event = { "BufRead", "BufNewFile" },
		build = function()
			vim.cmd("TSUpdate")
		end,
	},
	-- No-neck-pain
	["shortcuts/no-neck-pain.nvim"] = {},
	-- Colorizer
	["NvChad/nvim-colorizer.lua"] = {},
	-- Indent Blankline (indent-blankline + mini.indent)
	["lukas-reineke/indent-blankline.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
	},
	["echasnovski/mini.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
	},
	["stevearc/conform.nvim"] = {
		event = "BufReadPre",
	},
	["HakonHarnes/img-clip.nvim"] = {
		event = "BufEnter",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
		},
	},
	["3rd/image.nvim.git"] = {},
	-- Arrow.nvim
	["otavioschwanck/arrow.nvim"] = {},
}

for url, opts in pairs(plugins) do
	Balls:register("https://github.com/" .. url, opts)
end
