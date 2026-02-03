return {

	-- AI / Copilot
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				"zbirenbaum/copilot.lua",
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
			"MeanderingProgrammer/render-markdown.nvim",
			"folke/snacks.nvim",
			{
				-- Support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
		opts = {
			instructions_file = "avante.md",
			input = { provider = "snacks" },
			selector = { provider = "snacks" },
			behaviour = { support_paste_from_clipboard = true },
			web_search_engine = {
				provider = "tavily",
			},
			provider = "ollama",
			providers = {
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					timeout = 30000,
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				},
				copilot = {
					endpoint = "https://api.githubcopilot.com",
					model = "gpt-4o-2024-11-20",
					allow_insecure = false,
					timeout = 30000,
					context_window = 64000,
					support_previous_response_id = false,
					extra_request_body = {
						-- temperature is not supported by Response API for reasoning models
						max_tokens = 20480,
					},
				},
				groq = {
					__inherited_from = "openai",
					api_key_name = "GROQ_API_KEY",
					endpoint = "https://api.groq.com/openai/v1/",
					model = "llama-3.3-70b-versatile",
					disable_tools = true,
					extra_request_body = {
						temperature = 1,
						max_tokens = 32768,
					},
				},
				ollama = {
					is_env_set = function()
						require("avante.providers.ollama").check_endpoint_alive()
					end,
				},
			},
		},
	},
}
