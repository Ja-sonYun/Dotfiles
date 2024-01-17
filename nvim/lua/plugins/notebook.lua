return {
	{
		"kiyoon/jupynium.nvim",
		lazy = true,
		event = "BufEnter *.ju.*",
		build = "pipx run --spec notebook python -m pip install .",
		config = function()
			require("jupynium").setup({
				python_host = { "pipx", "run", "--spec", "notebook", "python" },
				jupyter_command = { "pipx", "run", "--spec", "notebook", "jupyter", "notebook" },
				default_notebook_URL = "localhost:8888",
				use_default_keybindings = false,
				scroll = {
					page = { step = 0.2 },
					cell = {
						top_margin_percent = 20,
					},
				},
			})
		end,
		init = function()
			hl = require("highlight")
			hl.set("JupyniumCodeCellSeparator", { ctermbg = 234, ctermfg = 51, underline = true })
			hl.set("JupyniumMarkdownCellSeparator", { ctermbg = 236, ctermfg = 3, underline = true })
			hl.set("JupyniumMarkdownCellContent", { ctermbg = 234 })

			local augroup = vim.api.nvim_create_augroup("jupynium-keymap", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
				pattern = "*.ju.*",
				callback = function(event)
					local buf_id = event.buf
					vim.keymap.set(
						{ "n", "x" },
						"qp",
						"<cmd>JupyniumExecuteSelectedCells<CR>",
						{ buffer = buf_id, desc = "Jupynium execute selected cells" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"qp",
						"<cmd>JupyniumExecuteSelectedCells<CR>",
						{ buffer = buf_id, desc = "Jupynium execute selected cells" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"<space>c",
						"<cmd>JupyniumClearSelectedCellsOutputs<CR>",
						{ buffer = buf_id, desc = "Jupynium clear selected cells" }
					)
					vim.keymap.set(
						{ "n" },
						"<space>K",
						"<cmd>JupyniumKernelHover<cr>",
						{ buffer = buf_id, desc = "Jupynium hover (inspect a variable)" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"<space>js",
						"<cmd>JupyniumScrollToCell<cr>",
						{ buffer = buf_id, desc = "Jupynium scroll to cell" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"<space>jo",
						"<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
						{ buffer = buf_id, desc = "Jupynium toggle selected cell output scroll" }
					)
					vim.keymap.set(
						"",
						"<PageUp>",
						"<cmd>JupyniumScrollUp<cr>",
						{ buffer = buf_id, desc = "Jupynium scroll up" }
					)
					vim.keymap.set(
						"",
						"<PageDown>",
						"<cmd>JupyniumScrollDown<cr>",
						{ buffer = buf_id, desc = "Jupynium scroll down" }
					)
					vim.keymap.set(
						{ "n" },
						"<space>ji",
						":JupyniumStartAndAttachToServer<cr>",
						{ buffer = buf_id, desc = "Jupynium load from ipynb tab" }
					)
					vim.keymap.set(
						{ "n" },
						"<space>ja",
						":JupyniumLoadFromIpynbTabAndStartSync ",
						{ buffer = buf_id, desc = "Jupynium load from ipynb tab and start sync" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"<leader>r",
						"<cmd>JupyniumKernelRestart<cr>",
						{ buffer = buf_id, desc = "Jupynium kernel restart" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"<leader>w",
						"<cmd>JupyniumSaveIpynb<cr>",
						{ buffer = buf_id, desc = "Jupynium save ipynb" }
					)
					vim.keymap.set(
						{ "n", "x" },
						"<space>c",
						"<cmd>JupyniumKernelInterrupt<cr>",
						{ buffer = buf_id, desc = "Jupynium kernel interrupt" }
					)
				end,
				group = augroup,
			})
		end,
	},
}
