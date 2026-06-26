return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = { "nvim-mini/mini.icons" },
		config = function()
			require("bufferline").setup({
				options = {
					themable = true,
					indicator = { style = "underline" },
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
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "left",
							separator = true,
						},
					},
				},
				highlights = { fill = { bg = Colors.bg_statusline }, separator = { fg = Colors.fg_dark } },
			})
		end,
	},
}
