return {
	{
		-- Tema suave e agradável
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
		-- Barra de status
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox",
				},
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
}
