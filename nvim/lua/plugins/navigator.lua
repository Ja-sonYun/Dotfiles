return {
	{
		"christoomey/vim-tmux-navigator",
		config = function()
			local map = require("keymap")

			vim.g.tmux_navigator_no_mappings = 1

			map.n("<C-l>", ":<C-U>TmuxNavigateRight<CR>")
			map.n("<C-h>", ":<C-U>TmuxNavigateLeft<CR>")
			map.n("<C-j>", ":<C-U>TmuxNavigateDown<CR>")
			map.n("<C-k>", ":<C-U>TmuxNavigateUp<CR>")
		end,
	},
}
