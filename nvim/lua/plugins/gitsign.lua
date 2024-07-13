-----------------------------------------------------------
-- GitSign
-----------------------------------------------------------

-- 'signs.add.hl' is now deprecated, please define highlight 'GitSignsAdd'
-- 'signs.change.hl' is now deprecated, please define highlight 'GitSignsChange'
-- 'signs.changedelete.hl' is now deprecated, please define highlight 'GitSignsChangedelete'
-- 'signs.delete.hl' is now deprecated, please define highlight 'GitSignsDelete'
-- 'signs.topdelete.hl' is now deprecated, please define highlight 'GitSignsTopdelete'
-- 'signs.untracked.hl' is now deprecated, please define highlight 'GitSignsUntracked'
return {
	{
		"lewis6991/gitsigns.nvim",
		init = function()
			local hl = require("highlight")

			hl.set("GitSignsAdd", { ctermbg = nil, ctermfg = "Green" })
			hl.set("GitSignsChange", { ctermbg = nil, ctermfg = "Yellow" })
			hl.set("GitSignsChangeDelete", { ctermbg = nil, ctermfg = "Yellow" })
			hl.set("GitSignsDelete", { ctermbg = nil, ctermfg = "Red" })
			hl.set("GitSignsTopDelete", { ctermbg = nil, ctermfg = "Red" })
			hl.set("GitSignsUntracked", { ctermbg = nil, ctermfg = "Cyan" })
		end,
		opts = {
			signs = {
				add = { text = "| " },
				change = { text = "| " },
				delete = { text = "| " },
				topdelete = { text = "| " },
				changedelete = { text = "| " },
				untracked = { text = "| " },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = true,
			},
			current_line_blame_formatter = "<author>,<author_time:%Y-%m-%d>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "none",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local hl = require("highlight")
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map({ "n", "v" }, "ghs", ":Gitsigns stage_hunk<CR>")
				map({ "n", "v" }, "ghr", ":Gitsigns reset_hunk<CR>")
				map("n", "ghS", gs.stage_buffer)
				map("n", "ghu", gs.undo_stage_hunk)
				map("n", "ghR", gs.reset_buffer)
				map("n", "H", gs.preview_hunk)
				map("n", "ghb", function()
					gs.blame_line({ full = true })
				end)
				-- map('n', 'qtb', gs.toggle_current_line_blame)
				map("n", "ghd", gs.diffthis)
				map("n", "ghD", function()
					gs.diffthis("~")
				end)
				map("n", "gtd", gs.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

				hl.set("GitSignsAddPreview", { ctermbg = 17 })
				hl.set("GitSignsDeletePreview", { ctermbg = 52 })
			end,
		},
	},
}
