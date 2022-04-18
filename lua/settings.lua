local o = vim.opt

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250

--Set colorscheme (order is important here)
vim.o.termguicolors = true
--vim.cmd [[colorscheme gruvbox]]

-- global settings
o.hidden = true
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.smarttab = true
o.showtabline = 2
o.autoindent = true
o.smartindent = true
o.undofile = true
o.cursorline = false
o.relativenumber = true
o.wrap = false
o.list = true
o.signcolumn = 'yes'
o.undodir = vim.fn.stdpath('config') .. '/undo'
o.laststatus = 0
o.showmode = false
o.ignorecase = true
o.scrolloff = 8
o.sidescrolloff = 8
o.shiftround = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.inccommand = 'nosplit'
o.errorbells = false
o.swapfile = false
o.backup = false
o.cmdheight = 1
o.pumheight = 25
o.pumblend = 10
o.syntax = 'enable'
o.colorcolumn = '80'
o.lazyredraw = true
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.formatoptions = 'cro'
o.clipboard = 'unnamedplus'
o.wildignore = '*/node_modules/*'

vim.cmd([[
    filetype indent plugin on
    au BufNewFile,BufRead *.es6 setf javascript
    au BufNewFile,BufRead *.tsx setf typescriptreact
    au BufNewFile,BufRead *.jsx setf javascriptreact
    au BufNewFile,BufRead *.md setf markdown
    au BufNewFile,BufRead *.mdx setf markdown
    set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md
]])

_G.global = {}
