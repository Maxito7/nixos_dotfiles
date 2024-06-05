require("nvim-treesitter.configs").setup({
	cmd = { "TSInstall", "TSUpdate" },
	event = { "BufRead", "BufNewFile" },
	build = function()
		vim.cmd("TSUpdate")
	end,
	ensure_installed = {
		"astro",
		"bash",
		"bibtex",
		"c",
		"cpp",
		"css",
		"gitcommit",
		"gitignore",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		-- "latex",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"php",
		"python",
		"query",
		"regex",
		"ruby",
		"rust",
		"slint",
		"sql",
		--"ssh_config",
		"templ",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
		"svelte",
		"vue",
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown " },
	},
	indent = { enable = true },
	-- context_commentstring = {
	--   enable = true,
	--   enable_autocmd = false,
	-- },
	autotag = { enable = true },
	autopairs = { enable = true },
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
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = { query = "@function.outer", desc = "Around the function" },
				["if"] = { query = "@function.inner", desc = "Inside the function" },
				["ac"] = { query = "@class.outer", desc = "Around the class" },
				["ic"] = { query = "@class.inner", desc = "Inside the class" },
				["aI"] = { query = "@conditional.outer", desc = "Around the conditional" },
				["iI"] = { query = "@conditional.inner", desc = "Inside the conditional" },
				["aL"] = { query = "@loop.outer", desc = "Around the loop" },
				["iL"] = { query = "@loop.inner", desc = "Inside the loop" },
				["aC"] = { query = "@comment.outer", desc = "Around the comment" },
				["iC"] = { query = "@comment.inner", desc = "Inside the comment" },
				["as"] = { query = "@scope", desc = "Language scope" },
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = { query = "@function.*", desc = "Next function start" },
				["]c"] = { query = "@class.*", desc = "Next class start" },

				-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				["]l"] = { query = "@loop.*", desc = "Go to next loop part" },
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
			},
			goto_next = {
				["]I"] = "@conditional.outer",
			},
			goto_previous = {
				["[I"] = "@conditional.outer",
			},
		},
	},
})
