return {

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
}
