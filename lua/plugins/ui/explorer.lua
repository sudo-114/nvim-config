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
}
