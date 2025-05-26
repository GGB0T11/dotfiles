return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local theme = require("config.theme")
            require("lualine").setup({
				options = {
					theme = theme.lualine_theme,
				},
			})
		end,
	},
    {
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				term_colors = true,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				italic = {
					strings = true,
					comments = true,
				},
				contrast = "hard",
				transparent_mode = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					functions = { bold = false },
				},
				on_highlights = function(hl, colors)
					hl.LineNr = { fg = colors.orange }
				end,
			})
		end,
	},
    {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
      config = function()
        require("everforest").setup({
            background = "medium",
            terminal_colors = true,
			italic = {
				strings = true,
				comments = true,
			},
            transparent_background_level = 2,
        })
      end,
    },

}
