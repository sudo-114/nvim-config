local md_ft = {
	"markdown",
	"vimwiki",
	"Avante",
	"notify",
	"blink-cmp-documentation",
	"trouble",
	"better_term",
	"noice",
	"virt_text",
	"codecompanion",
}

return {

	-- Render markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = md_ft,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
		opts = {
			preset = "none", --Options: "none", "lazy", "obsidian"
			completions = {
				lsp = { enabled = true },
				blink = { enabled = true },
			},
			anti_conceal = { enabled = false },
			file_types = md_ft,
		},
	},
}
