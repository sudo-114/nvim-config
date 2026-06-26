return {

	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon", -- Options: "storm", "moon", "night", "day"
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
		},
		config = function(opts)
			-- vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "auto", -- Options: latte, frappe, macchiato, mocha
			term_colors = true,
			dim_inactive = { enabled = true },
			auto_integrations = true,
			styles = {
				comments = { "italic" },
				keywords = { "bold" },
				functions = { "bold" },
				variables = { "italic" },
			},
		},
		config = function(opts)
			vim.cmd.colorscheme("catppuccin-nvim")
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
		opts = {
			options = {
				dim_inactive = true,
				styles = {
					comments = "italic",
					functions = "bold",
					keywords = "bold",
					variables = "italic",
				},
			},
		},
		config = function(opts)
			-- vim.cmd("colorscheme github_dark_dimmed")
		end,
	},
}
