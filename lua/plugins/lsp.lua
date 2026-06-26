-- lua/plugins/lsp.lua

local servers = {
	"vtsls",
	"cssls",
	"html",
	"pyright",
	"lua_ls",
	"tailwindcss",
	"emmet_language_server",
	"bashls",
	"qmlls",
}

local parsers = {
	"html",
	"css",
	"javascript",
	"typescript",
	"python",
	"lua",
	"markdown",
	"markdown_inline",
	"regex",
	"sql",
	"json",
	"latex",
	"bash",
	"tsx",
	"yaml",
	"vimdoc",
	"dart",
}

return {

	{ "folke/lazydev.nvim", ft = "lua", opts = {} },

	-- LSP actions
	{
		"jinzhongjia/LspUI.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"MeanderingProgrammer/render-markdown.nvim",
		},
		keys = {
			{ "K", "<cmd>LspUI hover<cr>" },
			{ "gh", "<cmd>LspUI inlay_hint<cr>", desc = "Toggle inlay hints" },
		},
		opts = { hover = { border = "rounded" } },
	},

	{
		"nvimdev/lspsaga.nvim",
		event = "LSPAttach",
		branch = "main",
		keys = {
			{ "gd", "<cmd>Lspsaga peek_definition<cr>" },
			{ "gD", "<cmd>Lspsaga goto_definition<cr>" },
			{ "gF", "<cmd>Lspsaga finder<cr>" },
			{ "go", "<cmd>Lspsaga outline<cr>" },
			{ "<leader>rn", "<cmd>Lspsaga rename<cr>" },
			{ "<leader>ca", "<cmd>Lspsaga code_action<cr>" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
		},
		opts = {
			code_action = { extend_gitsigns = true },
			finder = { number = true, relativenumber = false },
		},
	},

	-- Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = parsers,
				callback = function()
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	-- Autocompletion
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			cmdline = { sources = { "cmdline" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			completion = {
				keyword = { range = "full" },
				accept = { auto_brackets = { enabled = true } },
				documentation = { auto_show = true },
				menu = { auto_show = true, draw = { treesitter = { "lsp" } } },
				ghost_text = { enabled = true },
			},
			sources = {
				-- default = { "lsp", "snippets", "path", "buffer" }
				default = function()
					-- Dynamically determine sources based on context
					local success, node = pcall(vim.treesitter.get_node)
					if success and node and vim.tbl_contains({ "comment", "line_comment" }, node:type()) then
						return { "buffer" }
					end
					return { "lazydev", "codecompanion", "lsp", "snippets", "path", "buffer" }
				end,
				providers = {
					lsp = {
						async = true,
						fallbacks = { "buffer" },
						score_offset = 100,
					},
					path = {
						opts = {
							show_hidden_files_by_default = true,
						},
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					codecompanion = {
						name = "CodeCompanion",
						module = "codecompanion.providers.completion.blink",
					},
				},
			},
		},
	},

	-- LSP Installer and Configurator
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
		},
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						telemetry = { enable = false },
					},
				},
			})
			vim.lsp.config("copilot", {
				settings = {
					telemetry = {
						telemetryLevel = "off",
					},
				},
			})
			vim.lsp.config("vtsls", {
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "all" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
						},
					},
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = true,
			})
		end,
	},
}
