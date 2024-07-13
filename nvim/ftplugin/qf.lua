local map = require("keymap")

vim.opt_local.number = false
vim.opt_local.cursorline = true
vim.opt_local.statusline = "%n %f%=%L lines"

map.buf.n("q", ":q<CR>", { nowait = true })
map.buf.n("<C-c>", ":q<CR>", { nowait = true })
