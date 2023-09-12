local cmd = require("command")

cmd.new("Custom", function()
	local Menu = require("nui.menu")
	local event = require("nui.utils.autocmd").event

	local items = {
		Menu.item("Item 1"),
		Menu.item("Item 2"),
	}

	local menu = Menu({
		position = "50%",
		size = {
			width = 25,
			height = 5,
		},
		border = {
			style = "single",
			text = {
				top = "[Choose-an-Element]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = items,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("Menu Closed!")
		end,
		on_submit = function(item)
			print("Menu Submitted: ", item.text, item.index)
		end,
	})

	-- mount the component
	menu:mount()
end, {})

function Msg(msg, hl, timestamp)
	local current_buf = vim.api.nvim_get_current_buf()

	if timestamp == true then
		msg = "[" .. vim.fn.strftime("%H:%M:%S") .. "]: " .. msg
	end
	local length_of_args = #msg

	-- write string to buffer
	local Popup = require("nui.popup")
	local event = require("nui.utils.autocmd").event

	local win_width = vim.api.nvim_win_get_width(0)
	local win_height = vim.api.nvim_win_get_height(0)

	local popup = Popup({
		enter = false,
		focusable = false,
		relative = "win",
		anchor = "SE",
		border = {
			style = "none",
		},
		position = {
			row = win_height - 1,
			col = win_width,
		},
		size = {
			width = length_of_args,
			height = 1,
		},
	})

	-- mount/open the component
	popup:mount()

	-- unmount component when cursor leaves buffer
	vim.defer_fn(function()
		popup:unmount()
	end, 2500)

	-- set content
	vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { msg })
	vim.api.nvim_buf_add_highlight(popup.bufnr, -1, hl, 0, 0, -1)
end

cmd.new("Err", function(opts)
	_G.Msg(opts.args, "ErrorMsg", true)
end, { nargs = "*" })
cmd.new("Msg", function(opts)
	_G.Msg(opts.args, "Search", true)
end, { nargs = "*" })
