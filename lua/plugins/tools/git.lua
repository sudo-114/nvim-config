return {

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				-- sign_priority = 100,
				signs = {
					add = { hl = "GitSignsAdd" },
					change = { hl = "GitSignsChange" },
					delete = { hl = "GitSignsDelete" },
				},
			})
			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffff00" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000" })
			vim.keymap.set("n", "<leader>gw", "<cmd>Gitsigns<cr>", { desc = "Git window mininal" })
		end,
	},

	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"folke/snacks.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gG", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
		opts = {
			process_spinner = true,
			graph_style = "unicode", --Options: unicode, kitty, ascii
			integration = { snacks = true },
		},
	},
}
