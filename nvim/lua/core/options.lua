local is = require("condition")

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

opt.shiftround = true
opt.virtualedit = "block"

-----------------------------------------------------------
-- Ignore certain files and folders when globing
-----------------------------------------------------------
opt.wildignore:append(is.non_code)
opt.wildignorecase = true

-----------------------------------------------------------
-- Backups
-----------------------------------------------------------
vim.g.backupdir = vim.fn.expand(vim.fn.stdpath("data") .. "/backup//")
opt.backupdir = vim.g.backupdir
opt.backupskip = is.non_code
opt.backup = true
opt.backupcopy = "yes"

-- Undo
opt.undofile = true -- Enable persistent undo

-----------------------------------------------------------
-- Autocomplete
-----------------------------------------------------------
opt.completeopt = "menuone,noselect" -- Autocomplete options
opt.pumheight = 10
opt.pumblend = 0 -- transparency
opt.winblend = 0 -- pseudo transparency for floating window

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = false -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.splitkeep = "screen"

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
-- Folding
-----------------------------------------------------------
-- opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-----------------------------------------------------------
-- Code
-----------------------------------------------------------
opt.matchpairs:append({ "<:>", "「:」", "『:』", "【:】", "“:”", "‘:’", "《:》" })
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = false -- Enable 24-bit RGB colors
opt.ruler = true
opt.scrolloff = 3

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Autoindent new lines
opt.tabstop = 2
opt.softtabstop = 2

opt.list = true -- Show some invisible characters (tabs...)
opt.listchars = {
	tab = ". ", -- trailing space after the symbol
	extends = "❯",
	precedes = "❮",
	nbsp = "␣",
	trail = "~",
	leadmultispace = "|   ",
}

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

vim.cmd([[colorscheme vim]])
