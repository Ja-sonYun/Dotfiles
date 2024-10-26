local map = require("keymap")

map.buf.n("q", ":DiffviewClose<CR>", { nowait = true })
map.buf.n("<C-c>", ":DiffviewClose<CR>", { nowait = true })
