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
	{ "tpope/vim-eunuch" },
	{
		"tpope/vim-commentary",
		keys = {
			{ "\\c<Space>", "<Plug>Commentary", mode = "v" },
			{ "\\c<Space>", "<Plug>CommentaryLine", mode = "n" },
		},
	},

	{ "nvim-tree/nvim-web-devicons" },
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
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{ "tpope/vim-eunuch" },
	{ "mechatroner/rainbow_csv" },

	-- load plugins under plugins
	{ import = "plugins" },
})
