-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
local add = MiniDeps.add

add({
	source = "utilyre/barbecue.nvim",
	depends = {
		"nvim-tree/nvim-web-devicons",
		"SmiteshP/nvim-navic",
	},
})
add("nvim-lualine/lualine.nvim")
add({
	source = "nvim-telescope/telescope-fzf-native.nvim",
	hooks = {
		on_sync = function(plugin)
			vim.system({ "make" }, { cwd = plugin:path() }, function(result)
				print("compiled fzf!")
			end)
		end,
	},
})
add({
	source = "nvim-telescope/telescope.nvim",
	depends = {
		"nvim-lua/plenary.nvim",
	},
})
add("folke/tokyonight.nvim")
add("stevearc/oil.nvim")
add({
	source = "windwp/nvim-autopairs",
	depends = {
		"folke/neodev.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"hrsh7th/nvim-cmp",
	},
})
add({
	source = "nvim-treesitter/nvim-treesitter",
	depends = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
})
add("shortcuts/no-neck-pain.nvim")
add("NvChad/nvim-colorizer.lua")
add("lukas-reineke/indent-blankline.nvim")
add("stevearc/conform.nvim")
add("HakonHarnes/img-clip.nvim")
add("otavioschwanck/arrow.nvim")
