---@class vim
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
			-- vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
				dim_inactive = { enabled = true },
				term_colors = true,
				styles = {
					comments = { "italic" },
					keywords = { "bold" },
					functions = { "bold" },
					variables = { "italic" },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
