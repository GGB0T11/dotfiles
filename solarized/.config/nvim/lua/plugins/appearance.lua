return {
    {
        "svrana/neosolarized.nvim",
        lazy = false,
        priority = 1000,
        dependencies = { "tjdevries/colorbuddy.nvim" },
        config = function()
            require("neosolarized").setup({
                comment_italics = true,
                background_set = false,
          })
        end,
    },
}

