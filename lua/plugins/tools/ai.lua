local groq_models = {
	"groq/compound",
	"groq/compound-mini",
	"qwen/qwen3.6-27b",
	"qwen/qwen3.8-27b",
	"openai/gpt-oss-120b",
	"openai/gpt-oss-20b",
}

return {

	-- Code completion
	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"MeanderingProgrammer/render-markdown.nvim",
			"HakonHarnes/img-clip.nvim",
		},
		keys = {
			{ "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" } },
			{ "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion" },
			{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
		},
		opts = {
			opts = {
				log_level = "DEBUG",
			},
			interactions = { chat = { adapter = "groq" }, inline = { adapter = "groq" } },
			display = {
				action_palette = { provider = "snacks" },
				chat = {
					fold_context = true,
					icons = { chat_context = "📎️", chat_fold = " " },
					separator = "─",
					show_header_separator = true,
					window = { width = 0.3 },
				},
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
									choices = {
										"google/gemma-4-e4b",
										-- add other lmstudio models if needed
									},
								},
							},
						})
					end,
					groq = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							name = "groq",
							env = {
								url = "https://api.groq.com/openai/v1",
								chat_url = "/chat/completions",
								api_key = "GROQ_API_KEY",
							},
							schema = {
								model = {
									default = "groq/compound",
									choices = groq_models,
								},
							},
						})
					end,
				},
			},
		},
	},
}
