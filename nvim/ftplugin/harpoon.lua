local map = require("keymap")

map.buf.n("<C-c>", "<esc>")

vim.opt_local.bufhidden = "wipe"
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorline = true
