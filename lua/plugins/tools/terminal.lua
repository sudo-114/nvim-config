return {

	-- Terminal
	{
		"CRAG666/betterTerm.nvim",
		keys = {
			{
				"<M-;>",
				'<cmd>lua require("betterTerm").open()<cr>',
				mode = { "n", "t" },
				desc = "Open BetterTerm 0",
			},
			{
				"<M-/>",
				'<cmd>lua require("betterTerm").open(1)<cr>',
				mode = { "n", "t" },
				desc = "Open BetterTerm 1",
			},
			{ "<leader>tt", '<cmd>lua require("betterTerm").select()<cr>', desc = "Select terminal" },
		},
		opts = {
			position = "bot",
			size = 10,
			new_tab_mapping = "<C-t>",
			jump_tab_mapping = "<A-$tab>",
		},
	},

	-- Code runner
	{
		"CRAG666/code_runner.nvim",
		keys = {
			{ "<leader>rr", "<cmd>RunCode<cr>", desc = "Run code" },
			{ "<leader>rp", "<cmd>RunProject<cr>", desc = "Run project" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			mode = "better_term", -- Options: term", "tab", "better_term", "toggleterm", "vimux"
			better_term = { clean = true, number = nil },
			filetype_path = vim.fn.expand("~/.config/nvim/code_runner.json"),
			project_path = vim.fn.expand("~/.config/nvim/project_manager.json"),
		},
	},

	-- Diagnoatics view
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
}
