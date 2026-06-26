return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{
				"<leader>qs",
				'<cmd>lua require("persistence").load()<cr>',
				desc = "Load session for current dir",
			},
			{ "<leader>qS", '<cmd>lua require("persistence").select()<cr>', desc = "Select a session to load" },
			{ "<leader>ql", '<cmd>lua require("persistence").load({last = true})<cr>', desc = "Load the last session" },
			{ "<leader>qd", '<cmd>lua require("persistence").stop()<cr>', desc = "Stop persistence" },
		},
	},
}
