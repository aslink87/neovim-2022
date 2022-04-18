-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Run python script with F9
vim.cmd [[
  augroup PythonRun
    autocmd Filetype python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd Filetype python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  augroup end
]]
