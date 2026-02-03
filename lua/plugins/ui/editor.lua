---@class vim
vim.diagnostic.config({
	severity_sort = true,
	underline = true,
	-- virtual_lines = true,
	virtual_text = { prefix = "●" },
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘ ",
			[vim.diagnostic.severity.WARN] = " ", -- 󰀪
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

return {
	-- Breadcrumbs
	{
		"Bekaboo/dropbar.nvim",
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		config = function()
			local dropbar_api = require("dropbar.api")
			local map = vim.keymap.set
			map("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			map("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			map("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},

	-- UI improvements (Noice, Notify, Dressing)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				command_palette = true,
				long_message_to_split = true,
				bottom_search = true,
				lsp_doc_border = true,
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<M-n>",
				"<cmd>lua require('notify').dismiss()<cr>",
				mode = { "n", "x", "s", "t", "i" },
				desc = "Dismiss notifications",
			},
		},
		opts = {},
	},

	-- Icons
	{
		"nvim-mini/mini.icons",
		lazy = true,
		version = "*",
		config = function()
			local miniIcons = require("mini.icons")
			miniIcons.setup()
			miniIcons.mock_nvim_web_devicons()
		end,
	},

	-- Rainbow braces
	{ "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },

	-- Color column
	{ "Bekaboo/deadcolumn.nvim", event = "InsertEnter", opts = {} },

	-- Color highlighter
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			render = "background", -- Options: "background", "foreground", "virtual"
			enable_tailwind = true,
		},
	},

	-- Keymaps
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern", --  Options: "modern", "classic", "helix"
		},
	},
}
