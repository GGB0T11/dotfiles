return {
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
