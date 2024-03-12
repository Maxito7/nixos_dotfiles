require("conform").setup({
	formatters = {
		ruff_isort = {
			command = "ruff",
			args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_isort", "ruff_format" },
		go = { "gofumpt" },
		nix = { "alejandra", "nixpkgs_fmt" },
		javascript = { "biome" },
		typescript = { "biome" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 6000,
		lsp_fallback = false,
	},
})
