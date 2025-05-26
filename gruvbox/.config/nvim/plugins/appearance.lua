return {
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
}
