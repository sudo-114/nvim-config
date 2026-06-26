return {

	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
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
			})
			vim.cmd.colorscheme("tokyonight")

			Colors = require("tokyonight.colors").setup()
		end,
	},
}
