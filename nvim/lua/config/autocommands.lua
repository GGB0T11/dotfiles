-- Ajustar indentação para arquivos Python
vim.cmd([[
  augroup python_indent
    autocmd!
    autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
  augroup END
]])
