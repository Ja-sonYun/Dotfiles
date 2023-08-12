return {
	{ "junegunn/fzf.vim" },
	{
		"junegunn/fzf",
		build = ":call fzf#install()",
		config = function()
			local map = require("keymap")
			local auto = require("autocmd")

			vim.g.fzf_layout = { down = "20%" }

			map.n("<space>f", ":Files<CR>")
			map.n("<space>r", ":Rg<CR>")

			auto.group("Fzf", { clear = true })
			auto.cmd("FileType", {
				group = "Fzf",
				pattern = "fzf",
				callback = function(opts)
					map.buf.n("q", ":q<CR>", opts.buffer, { nowait = true })
					map.buf.n("<C-c>", ":q<CR>", opts.buffer, { nowait = true })
				end,
			})
		end,
	},
}
