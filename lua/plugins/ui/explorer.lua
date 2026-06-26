return {

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
				"<cmd>Neotree focus left<cr>",
				desc = "Toggle file explorer left",
			},
		},
		opts = {
			popup_border_style = "rounded",
			enable_cursor_hijack = true,
			use_libuv_file_watcher = true,
			follow_current_file = { enabled = true },
			source_selector = {
				winbar = true,
			},
			default_component_configs = {
				icon = {
					-- Setting mini icons as default icon provider
					provider = function(icon, node)
						local is_mini_icons, mini_icons = pcall(require, "mini.icons")
						if not is_mini_icons then
							return
						end

						if node.type == "file" or node.type == "directory" or node.type == "terminal" then
							local category
							if node.type == "terminal" then
								category = "filetype"
							elseif node.type == "directory" then
								category = "directory"
							elseif node.type == "file" then
								category = "file"
							end

							local name = node.type == "terminal" and "terminal" or node.name

							if category then
								local devicon, hl = mini_icons.get(category, name)

								if category == "directory" and node:is_expanded() then
									icon.text = ""
								elseif node.children and #node.children == 0 then
									icon.text = "󰷏"
								else
									icon.text = devicon or icon.text
								end

								icon.highlight = hl or icon.highlight
							end
						end
					end,
				},
				modified = { symbol = "" },
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
}
