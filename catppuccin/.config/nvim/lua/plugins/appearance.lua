return{
    {
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                show_end_of_buffer = false,
                term_colors = true,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                },
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true,
                    mini = true,
                },
            })
        end, 
    } 
}
