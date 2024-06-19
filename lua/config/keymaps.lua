-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local silent = { silent = true }

-- Dont yank on delete char
keymap.set("n", "x", '"_x', silent)
keymap.set("n", "X", '"_X', silent)
keymap.set("v", "x", '"_x', silent)
keymap.set("v", "X", '"_X', silent)

-- Dont yank on visual paste
keymap.set("v", "p", '"_dP', silent)

keymap.set("x", "K", ":move '<-2<CR>gv-gv", silent)
keymap.set("x", "J", ":move '>+1<CR>gv-gv", silent)
