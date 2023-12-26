return {
	"stevearc/conform.nvim",
	event = "BufReadPre",
	config = function()
		vim.g.disable_autoformat = false
		-- Conform setup
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "ruff" },
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
	end,
}