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
	local new_buffer = vim.api.nvim_create_buf(false, true)
	local max_x = vim.api.nvim_win_get_width(0)
	local max_y = vim.api.nvim_win_get_height(0)
	if timestamp == true then
		msg = "[" .. vim.fn.strftime("%H:%M:%S") .. "]: " .. msg
	end
	local length_of_args = #msg
	-- write string to buffer
	vim.api.nvim_buf_set_lines(new_buffer, 0, -1, false, { msg })
	vim.api.nvim_buf_add_highlight(new_buffer, -1, hl, 0, 0, -1)
	local new_win = vim.api.nvim_open_win(new_buffer, false, {
		relative = "win",
		bufpos = { 0, 0 },
		width = length_of_args,
		height = 1,
		col = max_x - length_of_args - 1,
		row = max_y - 2,
		focusable = false,
		style = "minimal",
		noautocmd = true,
	})
	vim.defer_fn(function()
		vim.api.nvim_win_close(new_win, true)
	end, 2000)
end

cmd.new("Err", function(opts)
	_G.Msg(opts.args, "ErrorMsg", true)
end, { nargs = "*" })
cmd.new("Msg", function(opts)
	_G.Msg(opts.args, "Search", true)
end, { nargs = "*" })

cmd.new("Fid", function(opts)
	local Timer = Popup:extend("Timer")

	function Timer:init(popup_options)
		local options = vim.tbl_deep_extend("force", popup_options or {}, {
			border = "double",
			focusable = false,
			position = { row = 0, col = "100%" },
			size = { width = 10, height = 1 },
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:SpecialChar",
			},
		})

		Timer.super.init(self, options)
	end

	function Timer:countdown(time, step, format)
		local function draw_content(text)
			local gap_width = 10 - vim.api.nvim_strwidth(text)
			vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, {
				string.format(
					"%s%s%s",
					string.rep(" ", math.floor(gap_width / 2)),
					text,
					string.rep(" ", math.ceil(gap_width / 2))
				),
			})
		end

		self:mount()

		local remaining_time = time

		draw_content(format(remaining_time))

		vim.fn.timer_start(step, function()
			remaining_time = remaining_time - step

			draw_content(format(remaining_time))

			if remaining_time <= 0 then
				self:unmount()
			end
		end, { ["repeat"] = math.ceil(remaining_time / step) })
	end

	local timer = Timer()

	timer:countdown(10000, 1000, function(time)
		return tostring(time / 1000) .. "s"
	end)
end, { nargs = "*" })
