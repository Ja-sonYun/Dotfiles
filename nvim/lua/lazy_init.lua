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

	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-eunuch" },
	{
		"tpope/vim-commentary",
		keys = {
			{ "\\c<Space>", "<Plug>Commentary", mode = "v" },
			{ "\\c<Space>", "<Plug>CommentaryLine", mode = "n" },
		},
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

	-- load plugins under plugins
	{ import = "plugins" },
})
