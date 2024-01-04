vim.cmd.packadd("conform.nvim")
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
		-- Conform will run multiple formatters sequentially
		python = { "ruff_isort", "ruff_format" },
		go = { "gofumpt" },
		-- Use a sub-list to run only the first available formatter
		--javascript = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 6000,
		lsp_fallback = true,
	},
})
