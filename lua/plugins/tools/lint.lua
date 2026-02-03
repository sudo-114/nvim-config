local linter = {
	php = { "phpstan" },
	sql = { "sqlfluff" },
	javascript = { "oxlint" },
	javascriptreact = { "oxlint" },
	typescript = { "oxlint" },
	typescriptreact = { "oxlint" },
}

return {

	--  Linters
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = linter
			-- Auto-lint on those events
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					if vim.bo.modifiable and vim.fn.line("$") < 5000 then
						lint.try_lint()
					end
				end,
			})
		end,
	},

	-- Auto install linters
	{
		"rshkarin/mason-nvim-lint",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-lint", "williamboman/mason.nvim" },
		config = true,
	},
}
