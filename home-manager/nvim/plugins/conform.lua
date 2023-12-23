-- Conform setup
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "ruff" },
		go = { "gci", "gofumpt" },
		-- Use a sub-list to run only the first available formatter
		--javascript = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 0,
		lsp_fallback = true,
	},
})
