-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- -- Only way i am able to get treesitter to fold is in manual mode
local opt = vim.opt
opt.foldmethod = "manual"
