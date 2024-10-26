local map = require("keymap")

vim.opt_local.number = false
vim.opt_local.cursorline = true

map.buf.n("q", ":q<CR>", { nowait = true })
map.buf.n("<C-c>", ":q<CR>", { nowait = true })

map.buf.n("l", "<CR>", { nowait = true })
