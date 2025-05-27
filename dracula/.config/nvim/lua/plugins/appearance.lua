return {
    {
        'maxmx03/dracula.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
            require("dracula").setup({
                transparent = true,
                plugins = {
                    ["nvim-treesitter"] = true,
                    ["rainbow-delimiters"] = true,
                    ["nvim-lspconfig"] = true,
                    ["nvim-navic"] = true,
                    ["nvim-cmp"] = true,
                    ["indent-blankline.nvim"] = true,
                    ["neo-tree.nvim"] = true,
                    ["nvim-tree.lua"] = true,
                    ["which-key.nvim"] = true,
                    ["dashboard-nvim"] = true,
                    ["gitsigns.nvim"] = true,
                    ["neogit"] = true,
                    ["todo-comments.nvim"] = true,
                    ["lazy.nvim"] = true,
                    ["telescope.nvim"] = true,
                    ["noice.nvim"] = true,
                    ["hop.nvim"] = true,
                    ["mini.statusline"] = true,
                    ["mini.tabline"] = true,
                    ["mini.starter"] = true,
                    ["mini.cursorword"] = true,
                    ['bufferline.nvim'] = true,
                }
            })
        end
    },
}
