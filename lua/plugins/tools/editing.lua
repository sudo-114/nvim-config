return {

	-- Comments
	{ "numToStr/Comment.nvim", event = { "BufReadPost", "BufNewFile" }, opts = {} },

	-- Auto Pairs
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = {},
	},

	-- Auto-closing tags for HTML/XML
	{ "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },

	-- Surround
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	-- Color picker
	{
		"uga-rosa/ccc.nvim",
		cmd = "CccPick",
		keys = {
			{ "<M-c>", "<cmd>CccPick<cr>", mode = "n", desc = "Color picker" },
		},
		opts = {
			bar_len = 45,
			preserve = true,
		},
	},

	-- Indent
	{
		"nmac427/guess-indent.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			auto_cmd = true,
			override_editorconfig = false,
		},
	},

	-- Emmet abbreviation
	{
		"olrtg/nvim-emmet",
		keys = {
			{
				"<leader>xe",
				'<cmd>lua require("nvim-emmet").wrap_with_abbreviation()<cr>',
				mode = { "n", "v" },
			},
		},
	},
}
