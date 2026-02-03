-- lua/plugins/tools.lua
local formatters = {
	lua = { "stylua" },
	php = { "pint" },
	python = { "black" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	html = { "prettier" },
	css = { "prettier" },
	json = { "prettier" },
	markdown = { "prettier" },
	sh = { "shfmt" },
	sql = { "pg_format" },
}

local linter = {
	php = { "phpstan" },
	sql = { "sqlfluff" },
	javascript = { 'oxlint' },
	javascriptreact = { 'oxlint' },
	typescript = { 'oxlint' },
	typescriptreact = { 'oxlint' },
}

local md_ft = {
	"markdown",
	"vimwiki",
	"Avante",
	"snacks_notif",
	"help",
	"blink-cmp-documentation",
	'trouble'
}

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

	-- Formatters
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		opts = {
			formatters_by_ft = formatters,
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 5000,
			},
		},
	},

	-- Auto install formatters
	{
		"zapling/mason-conform.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
		config = true,
	},

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
				}
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
			provider = "claude",
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
				ollama = {
					endpoint = "http://127.0.0.1:11434",
					timeout = 30000,
					use_ReAct_prompt = true,
					extra_request_body = {
						options = {
							temperature = 0.75,
							num_ctx = 20480,
							keep_alive = "5m",
						},
					},
				},
			},
		},
	},

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

	-- Render markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = md_ft,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
		opts = {
			preset = "none", --Options: "none", "lazy", "obsidian"
			completions = {
				lsp = { enabled = true },
				blink = { enabled = true },
			},
			anti_conceal = { enabled = false },
			file_types = md_ft,
		},
	},

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
			size = 20,
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
