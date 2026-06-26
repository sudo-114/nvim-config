return {

	-- Flutter tools
	{
		"nvim-flutter/flutter-tools.nvim",
		ft = "dart",
		-- lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>fd", "<cmd>Telescope flutter commands<cr>", desc = "Flutter commands" },
		},
		config = function()
			local flutter_path = vim.fn.exepath("flutter")

			if flutter_path == "" then
				vim.notify("Flutter not found in PATH", vim.log.level.WARN)
				flutter_path = ""
			end

			require("flutter-tools").setup({
				flutter_path = flutter_path,
				root_patterns = { ".git", "pubspec.yaml" },
				widget_guides = { enabled = true },
				ui = { notification_style = "plugin" },
				debugger = { enabled = true },
				dev_log = {
					enabled = false,
					notify_errors = false,
					focus_on_open = false,
					open_cmd = "botright 10split",
				},
				decorations = {
					statusline = {
						app_version = true,
						device = true,
					},
				},
			})
			require("telescope").load_extension("flutter")

			require("flutter-tools").setup_project({
				{
					name = "Web",
					device = "chrome",
					additional_args = { "--no-web-resources-cdn" },
				},
				{ name = "Mobile", device = "192.168.240.112:5555" },
			})
		end,
	},
}
