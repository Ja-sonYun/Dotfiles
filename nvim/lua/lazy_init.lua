-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = " "
require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-eunuch" },
	{ "sindrets/diffview.nvim" },
	{
		"tpope/vim-commentary",
		keys = {
			{ "\\c<Space>", "<Plug>Commentary", mode = "v" },
			{ "\\c<Space>", "<Plug>CommentaryLine", mode = "n" },
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{ "rmagatti/goto-preview" },

	{
		"simeji/winresizer",
		init = function()
			vim.g.winresizer_start_key = "<C-a>"
		end,
	},

	{
		"mattn/emmet-vim",
		init = function()
			vim.g.user_emmet_leader_key = "<C-X>"
		end,
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				-- delay: delay in milliseconds
				delay = 200,
			})
			local hl = require("highlight")
			hl.set("IlluminatedWordText", { cterm = { underline = true } })
			hl.set("IlluminatedWordRead", { cterm = { underline = true } })
			hl.set("IlluminatedWordWrite", { cterm = { underline = true } })
		end,
	},

	-- load plugins under plugins
	{ import = "plugins" },
})
