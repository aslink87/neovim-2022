local f = require("utils.functions")
local keymap = vim.keymap
local silent = { silent = true }

-- tabs
keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- remove highlighting
keymap.set("n", "<esc><esc>", ":nohlsearch<cr>", silent)

-- remove trailing white space
f.cmd("Nows", "%s/\\s\\+$//e", { desc = "remove trailing whitespace" })

-- remove blank lines
f.cmd("Nobl", "g/^\\s*$/d", { desc = "remove blank lines" })

-- fix syntax highlighting
f.cmd("FixSyntax", "syntax sync fromstart", { desc = "reload syntax highlighting" })

-- vertical term
f.cmd("T", ":vs | :set nu! | :term", { desc = "vertical terminal" })

-- move blocks
keymap.set("x", "K", ":move '<-2<CR>gv-gv", silent)
keymap.set("x", "J", ":move '>+1<CR>gv-gv", silent)

-- focus scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })

-- focus highlight searches
keymap.set("n", "n", "nzzzv", { desc = "next match" })
keymap.set("n", "N", "Nzzzv", { desc = "prev match" })

-- remove trailing whitespaces and ^M chars
f.autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function(_)
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Dont yank on visual paste
keymap.set("v", "p", '"_dP', silent)

-- Dont yank on delete char
keymap.set("n", "x", '"_x', silent)
keymap.set("n", "X", '"_X', silent)
keymap.set("v", "x", '"_x', silent)
keymap.set("v", "X", '"_X', silent)
