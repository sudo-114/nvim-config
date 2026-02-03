return {

	-- Snacks nvim
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>sd",
				'<cmd>lua Snacks.dashboard.open({ example = "advanced" })<cr>',
				desc = "Open Snacks dashboard",
			},
			{ "<leader>gg", "<cmd>lua	Snacks.lazygit.open()<cr>", desc = "Git window" },
			{
				"<leader>ff",
				"<cmd>lua Snacks.picker.files()<cr>",
				desc = "Find files",
			},
			{ "<leader>fg", "<cmd>lua Snacks.picker.grep()<cr>", desc = "Live grep" },
			{
				"<leader>fc",
				"<cmd>lua Snacks.picker.colorschemes()<cr>",
				mode = "n",
				desc = "Pick colorscheme",
			},
			{ "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", desc = "Help tags" },
			{ "<leader>fp", "<cmd>lua Snacks.picker.projects()<cr>", desc = "Find projects" },
			{
				"<M-i>",
				"<cmd>lua Snacks.picker.icons()<cr>",
				mode = { "n", "i", "v" },
				desc = "Select icons",
			},
		},
		opts = {
			dashboard = {
				enabled = true,
				example = "advanced", -- Options: "advanced", "github", "compact_files", "files"
			},
			image = { enabled = true, convert = { notify = true } },
			lazygit = { enabled = true },
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign" },
				right = { "fold", "git" },
				folds = { open = true, git_hl = true },
				refresh = 50,
			},
			input = { enabled = true },
			picker = {
				enabled = true,
				-- Options: default, telescope, sidebar, ivy, dropdown, vscode, select
				layout = "telescope",
				prompt = " ",
			},
			indent = { enabled = true, scope = { underline = true } },
		},
	},
}
