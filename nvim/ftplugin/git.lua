local map = require("keymap")

map.buf.n("q", ":q<CR>", { nowait = true })
map.buf.n("<C-c>", ":q<CR>", { nowait = true })
