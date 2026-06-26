return {

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-mini/mini.icons" },
		config = function()
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

			-- Left sections
			insert_left({
				"mode",
				icon = "",
			})
			insert_left({
				"branch",
				icon = "",
				color = { fg = Colors.fg, gui = "bold" },
			})
			insert_left({
				"diff",
				symbols = { added = " ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = "#51cb0b" },
					modified = { fg = "#ffff00" },
					removed = { fg = "#ff0000" },
				},
				cond = conditions.hide_in_width,
			})
			insert_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				update_in_insert = true,
				symbols = { error = "✘ ", warn = " ", info = " ", hint = " " },
				diagnostics_color = {
					color_error = { fg = Colors.error },
					color_warn = { fg = Colors.warning },
					color_info = { fg = Colors.info },
				},
			})
			-- CodeCompanion spinner
			insert_left({
				(function()
					local spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
					local spinner_len = #spinner_symbols
					local spinner_index = 0
					local processing = false

					local group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })
					vim.api.nvim_create_autocmd({ "User" }, {
						pattern = "CodeCompanionRequest*",
						group = group,
						callback = function(request)
							if request.match == "CodeCompanionRequestStarted" then
								processing = true
							elseif request.match == "CodeCompanionRequestFinished" then
								processing = false
							end
						end,
					})

					return function()
						if processing then
							spinner_index = (spinner_index % spinner_len) + 1
							return spinner_symbols[spinner_index]
						else
							return ""
						end
					end
				end)(),
			})
			-- Space
			insert_left({
				function()
					return "%="
				end,
			})

			-- Right sections
			insert_right({
				function()
					local dev = vim.g.flutter_tools_decorations.device
					return dev.name or dev.id
				end,
			})
			insert_right({
				function()
					return vim.g.flutter_tools_decorations.app_version
				end,
			})
			insert_right({ "lsp_status", cond = conditions.hide_in_width })
			insert_right({ "searchcount" })
			insert_right({ "filetype" })
			insert_right({
				"location",
				icon = "",
				color = { fg = Colors.fg },
				cond = conditions.buffer_not_empty,
			})
			insert_right({ "progress" })

			-- Load config
			require("lualine").setup(config)
		end,
	},
}
