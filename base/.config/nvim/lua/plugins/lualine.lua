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
}
