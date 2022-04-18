-- Solarized
vim.cmd('colorscheme solarized')
vim.g.solarized_italics = 1
vim.g.solarized_visibility = 'normal'
vim.g.solarized_diffmode = 'normal'
vim.g.solarized_statusline = 'low'
--vim.g.
vim.g.airline_solarized_normal_green = 1
vim.g.airline_theme = 'solarized'

-- To enable transparency
if vim.fn.has('gui_running') == 0 then
    vim.g.solarized_termtrans = 0
else
    vim.g.solarized_termtrans = 1
end

-- Gruvbox
--vim.cmd [[colorscheme gruvbox]]
--vim.cmd ([[
    --let g:gruvbox_contrast_light = 'soft'
    --let g:gruvbox_italic = '1'
    --let g:gruvbox_undercurl = '1'
    --let g:gruvbox_italicize_comments = '1'
--]])

--vim.g.airline_theme = 'minimalist'
