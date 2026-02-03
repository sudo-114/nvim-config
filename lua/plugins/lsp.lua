-- lua/plugins/lsp.lua

local servers = {
	"intelephense",
	"vtsls",
	"cssls",
	"html",
	"pyright",
	"lua_ls",
	"tailwindcss",
	"sqlls",
	"emmet_language_server",
	"copilot",
}

local parsers = {
	"php",
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
	"vim",
	"tsx",
}

return {
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
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = true,
			})
		end,
	},

	-- Autocompletion
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets", "Kaiser-Yang/blink-cmp-avante" },
		version = "*",
		opts = {
			cmdline = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			completion = {
				keyword = { range = "full" },
				accept = { auto_brackets = { enabled = true } },
				documentation = { auto_show = true },
				menu = { auto_show = true, draw = { treesitter = { "lsp" } } },
				ghost_text = { enabled = true },
			},
			sources = {
				-- default = { "avante", "lsp", "snippets", "path", "buffer" }
				default = function()
					-- Dynamically determine sources based on context
					local success, node = pcall(vim.treesitter.get_node)
					if success and node and vim.tbl_contains({ "comment", "line_comment" }, node:type()) then
						return { "buffer" }
					end
					return { "avante", "lsp", "snippets", "path", "buffer" }
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
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {},
					},
				},
			},
		},
	},

	-- LSP actions
	{
		"nvimdev/lspsaga.nvim",
		event = "LSPAttach",
		branch = "main",
		keys = {
			{ "K", "<cmd>Lspsaga hover_doc<cr>" },
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
			diagnostic = { auto_preview = true },
			code_action = { extend_gitsigns = true },
			lightbulb = { enable_in_insert = false },
			finder = { number = true, relativenumber = false },
			definition = { number = true, relativenumber = false },
			symbol_in_winbar = { folder_level = 2 },
			outline = { layout = "float" },
			implement = { enable = true },
			request_timeout = 3000,
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
}
