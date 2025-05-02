return {
    {
        -- Integra linters, formatadores e outras ferramentas
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim"
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                autostart = true,
                sources = {
                    require("none-ls.diagnostics.flake8"),
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.stylua,
                },
            })
        end,
    },
    {
        -- Melhora o destaque de sintaxe e navegação no código
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
