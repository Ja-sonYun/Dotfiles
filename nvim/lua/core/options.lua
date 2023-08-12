-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "" -- Disable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menuone,noselect" -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = false -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.splitkeep = "screen"

-- opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.
]])

opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = false -- Enable 24-bit RGB colors
opt.ruler = true

-- opt.laststatus=3            -- Set global statusline
opt.fillchars = {
	stl = "^",
	stlnc = "=",
	horiz = "-",
	horizup = "-",
	horizdown = "-",
	vert = "|",
	vertleft = "|",
	vertright = "|",
	verthoriz = "+",
	fold = "-",
	foldsep = "|",
}

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Autoindent new lines
opt.list = true -- Show some invisible characters (tabs...)

vim.cmd([[set wildcharm=<tab>]])

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append("sI")

-----------------------------------------------------------
-- DefaultTheme
-----------------------------------------------------------
opt.background = "light" -- Dark background
