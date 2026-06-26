return {

	-- AI
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		opts = {
			server_opts_overrides = {
				settings = {
					telemetry = {
						telemetryLevel = "off",
					},
				},
			},
		},
	},

	-- Code completion
	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"zbirenbaum/copilot.lua",
			"MeanderingProgrammer/render-markdown.nvim",
			"HakonHarnes/img-clip.nvim",
		},
		keys = {
			{ "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" } },
			{ "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion" },
			{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
		},
		opts = {
			interactions = {
				chat = {
					adapter = "copilot",
					model = "claude-haiku-4.5", -- claude-haiku-4.5, gpt-5-mini
				},
				inline = { adapter = "copilot" },
			},
			display = {
				chat = {
					separator = "─",
					show_header_separator = true,
					window = { width = 0.3 },
				},
				action_palette = { provider = "snacks" },
			},
			adapters = {
				http = {
					lmstudio = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							name = "lmstudio",
							env = {
								url = "http://localhost:1234",
								chat_url = "/v1/chat/completions",
							},
							schema = {
								model = {
									default = "google/gemma-4-e4b",
								},
							},
						})
					end,
				},
			},
		},
	},
}
