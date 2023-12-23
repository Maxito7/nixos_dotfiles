require('telescope').setup({
	extensions = {
    	fzf = {
      	fuzzy = true,                    -- false will only do exact matching
      	override_generic_sorter = true,  -- override the generic sorter
      	override_file_sorter = true,     -- override the file sorter
      	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    	}
  	},
		defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				width = 0.8,
				preview_width = 0.5,
			},
			vertical = {
				width = 0.7,
				height = 0.9,
				preview_cutoff = 1,
				prompt_position = "top",
				preview_height = 0.4,
				mirror = true,
			},
		},
	},
})

require('telescope').load_extension('fzf')
