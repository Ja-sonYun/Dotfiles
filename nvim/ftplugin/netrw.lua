local map = require("keymap")

vim.opt_local.bufhidden = "wipe"
vim.opt_local.number = false
vim.opt_local.relativenumber = false

map.buf.n("l", "<cr>")
map.buf.n("h", "-<esc>")
map.buf.n("a", "%<esc>")
map.buf.n("m", "R<esc>", { silent = false })
map.buf.n("r", ":e . <bar> echo 'Reloaded.'<cr>")

map.buf.n("q", ":Rex<cr>", { nowait = true })
map.buf.n("<C-c>", ":Rex<cr>", { nowait = true })
map.buf.n("<leader>f", ":Rex<cr>")

map.buf.n("<c-h>", ":TmuxNavigateLeft<cr>")
map.buf.n("<c-j>", ":TmuxNavigateDown<cr>")
map.buf.n("<c-k>", ":TmuxNavigateUp<cr>")
map.buf.n("<c-l>", ":TmuxNavigateRight<cr>")

vim.opt_local.listchars.multispace = "\\ "
