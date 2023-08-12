-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local map = require("keymap")

-- Change leader to a comma
vim.g.mapleader = ","

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
map.n("J", "<nop>")
map.v("K", "<nop>")

-- Clear search highlighting with <leader> and c
map.n("<leader>a", ":nohl<CR>")

-- Reload configuration without restart nvim
map.n("<leader>R", ":source ~/.config/nvim/init.lua|Msg init.lua reloaded!<CR>")
map.n("<leader>r", ":e!|LspStop<CR>:lua vim.diagnostic.reset()<CR>:Msg Reloaded<CR>:sleep 500m<CR>:LspStart<CR>")

-- Fast saving with <leader> and s
map.n("<leader>w", ":w|Msg file saved!<CR>")

-- Replace
map.u("n", "<C-s>r", "<ESC>*:%s///gc<left><left><left>")
map.u("n", "<C-s>R", "<ESC>*:%s///g<left><left>")
-- map.u("v", "<C-s>r", ":s//gc<left><left><left>")
-- map.u("v", "<C-s>R", ":s//g<left><left>")

-- terminal
map.t("<C-w>", "<C-\\><C-n><C-w>")
map.t("<C-h>", "<C-\\><C-n><C-w>h")
map.t("<C-j>", "<C-\\><C-n><C-w>j")
map.t("<C-k>", "<C-\\><C-n><C-w>k")
map.t("<C-l>", "<C-\\><C-n><C-w>l")
map.t("<C-[>", "<C-\\><C-n>")

map.u("n", "<leader>e", ":Shell ")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Remap incsearch
map.n("*", "#")
map.n("#", "*")

map.v("#", 'y/\\V<C-R>"<CR>')
map.v("*", 'y?\\V<C-R>"<CR>')

-- Remap tab
map.n("to", ":tabnew<cr>")
map.n("tq", ":tabclose<cr>")
map.n("tn", ":tabnext<cr>")
map.n("tp", ":tabprev<cr>")

map.n("<C-p>", '"0p')
map.v("<C-p>", '"0p')

-- Map cursor move on insert mode
map.i("<C-h>", "<Left>")
map.i("<C-j>", "<Down>")
map.i("<C-k>", "<Up>")
map.i("<C-l>", "<Right>")
