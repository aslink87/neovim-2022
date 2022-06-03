-- Install Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

--local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
--vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- colors/ui
  use 'ishan9299/nvim-solarized-lua'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'preservim/nerdcommenter'
  use 'kyazdani42/nvim-web-devicons'
  --use 'lukas-reineke/indent-blankline.nvim'
  -- telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- treesitter
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  -- QOL
  use 'windwp/nvim-ts-autotag'
  use 'ludovicchabant/vim-gutentags'
  use 'kevinoid/vim-jsonc'
  use 'windwp/nvim-autopairs'
  use 'scrooloose/NERDTree'
  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'onsails/lspkind-nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  -- cmp
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use "f3fora/cmp-spell"
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  -- null-ls
  --use 'jose-elias-alvarez/null-ls.nvim'
  -- snippets
  use 'rafamadriz/friendly-snippets'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- imports
require('settings')
require('keymaps')
require('themes')
require('commands')
require('lsp')
--require('nullls')
require('autopairs')
require('airline')
require('comp')
require('gutentags')
require('treesitter')
require('icons')
--require('telescope')

--telescope
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    file_ignore_patterns = { "^node_modules/" },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')
