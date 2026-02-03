-- lua/plugins/ui.lua
---@class vim
vim.diagnostic.config({
	severity_sort = true,
	underline = true,
	-- virtual_text = {
	-- 	prefix = "●",
	-- },
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
	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- Options: "storm", "moon", "night", "day"
				transparent = false,
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					functions = { bold = true },
					variables = { italic = true },
				},
				dim_inactive = true,
				lualine_bold = true,
				plugins = { auto = true },
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false,
					dim_inactive = true,
					styles = {
						comments = "italic",
						keywords = "bold",
						functions = "bold",
						variables = "italic",
					},
				},
				modules = {
					treesitter = true,
					gitsigns = true,
					neotree = true,
				},
			})
			-- vim.cmd([[colorscheme github_dark]])
		end,
	},

	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				transparent = false,
				cache = true,
			})
			-- vim.cmd([[colorscheme cyberdream]])
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-mini/mini.icons" },
		config = function()
			local colors = require("tokyonight.colors")
			local config = {
				options = {
					theme = "auto", --  Options: "auto", [other themes]
					section_separators = "",
					component_separators = "",
					globalstatus = true,
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				tabline = {},
			}
			local conditions = {
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
			}
			local function insert_left(component)
				table.insert(config.sections.lualine_c, component)
			end
			local function insert_right(component)
				table.insert(config.sections.lualine_x, component)
			end
			insert_left({
				"mode",
				icon = "",
			})
			insert_left({
				"branch",
				icon = "",
				color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
			})
			insert_left({
				"diff",
				symbols = { added = " ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})
			insert_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				update_in_insert = true,
				symbols = { error = "✘ ", warn = " ", info = " ", hint = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})
			insert_left({
				function()
					return "%="
				end,
			})
			insert_right({ "lsp_status", cond = conditions.hide_in_width })
			insert_right({ "searchcount" })
			insert_right({ "filetype" })
			-- insert_right({ "encoding" })
			insert_right({
				"location",
				color = { fg = colors.fg_dark },
				cond = conditions.buffer_not_empty,
			})
			insert_right({ "progress" })
			require("lualine").setup(config)
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = { "nvim-mini/mini.icons" },
		opts = {
			options = {
				show_tab_indicators = true,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diagnostics_dict, context)
					local s = " "
					if context.buffer:current() then
						return ""
					end
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and "✘ " or (e == "warning" and " " or " ")
						s = s .. n .. sym
					end
					return s
				end,
				indicator = {
					style = "underline",
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
			},
		},
	},

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

	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-mini/mini.icons", "MunifTanjim/nui.nvim" },
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree float toggle<cr>",
				desc = "Toggle file explorer float",
			},
			{
				"<leader>l",
				"<cmd>Neotree toggle left<cr>",
				desc = "Toggle file explorer left",
			},
		},
		opts = {
			popup_border_style = "rounded",
			enable_cursor_hijack = true,
			use_libuv_file_watcher = true,
			source_selector = {
				winbar = true,
			},
			default_component_configs = {
				icon = { default = "" },
				modified = { symbol = "" },
				name = {
					highlight_opened_files = true,
				},
			},
			filesystem = {
				commands = {
					avante_add_files = function(state)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local relative_path = require("avante.utils").relative_path(filepath)

						local sidebar = require("avante").get()

						local open = sidebar:is_open()
						-- ensure avante sidebar is open
						if not open then
							require("avante.api").ask()
							sidebar = require("avante").get()
						end

						sidebar.file_selector:add_selected_file(relative_path)

						-- remove neo tree buffer
						if not open then
							sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
						end
					end,
				},
				window = {
					mappings = {
						["oa"] = "avante_add_files",
					},
				},
			},
		},
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
				"<M-n>",
				"<cmd>lua Snacks.notifier.hide()<cr>",
				mode = { "n", "x", "s", "t", "i" },
				desc = "Dismiss all notifications",
			},
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
			statuscolumn = { enabled = true, folds = { open = true, git_hl = true } },
			input = { enabled = true },
			picker = {
				enabled = true,
				-- Options: default, telescope, sidebar, ivy, dropdown, vscode, select
				layout = "telescope",
				prompt = " ",
			},
			indent = { enabled = true, scope = { underline = true } },
			notifier = {
				enabled = true,
				style = "fancy", -- Options: "compact", "fancy", "minimal", "history"
			},
		},
	},
}
