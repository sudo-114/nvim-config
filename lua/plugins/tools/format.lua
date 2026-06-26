local formatters = {
	lua = { "stylua" },
	python = { "black" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	html = { "prettier" },
	css = { "prettier" },
	json = { "prettier" },
	markdown = { "prettier" },
	sh = { "shfmt" },
}

return {

	-- Formatters
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		opts = {
			formatters_by_ft = formatters,
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 5000,
			},
		},
	},

	-- Auto install formatters
	{
		"zapling/mason-conform.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
		opts = {},
	},
}
