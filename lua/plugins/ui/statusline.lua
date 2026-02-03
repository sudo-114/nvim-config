return {

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
}
