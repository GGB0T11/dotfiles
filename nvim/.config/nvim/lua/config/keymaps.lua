-- Global
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Local
local opts = { noremap = true, silent = true }

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, opts)

-- Neo-Tree
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", opts)
vim.keymap.set("n", "<C-t>", function()
    vim.cmd(vim.bo.filetype == "neo-tree" and "wincmd p" or "Neotree focus")
end, opts)

-- None-Ls
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)
vim.keymap.set("n", "<leader>gd", vim.diagnostic.open_float, opts)

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
