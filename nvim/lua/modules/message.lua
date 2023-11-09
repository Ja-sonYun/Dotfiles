local M = {}

local messages = {}

M.Msg = function(msg, hl, opts)
	local current_buf = vim.api.nvim_get_current_buf()

	local timestamp = opts and opts.timestamp or false

	if timestamp == true then
		msg = msg .. " [" .. vim.fn.strftime("%H:%M:%S") .. "]"
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
			col = win_width - 1,
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

		-- delete buffer from list of messages
		for i, v in ipairs(messages) do
			if v.bufnr == popup.bufnr then
				table.remove(messages, i)
			end
		end
	end, 2500)

	-- set content
	vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { msg })
	vim.api.nvim_buf_add_highlight(popup.bufnr, -1, hl, 0, 0, -1)

	-- if there's already a messages, move them up
	if #messages > 0 then
		local padding = 1
		-- iterate messages in reverse order
		for i = #messages, 1, -1 do
			local v = messages[i]
			if v.bufnr == popup.bufnr or vim.api.nvim_buf_is_valid(v.bufnr) == false then
				break
			end
			v:update_layout({
				position = {
					row = win_height - 1 - padding,
					col = v._.layout.position.col,
				},
			})
			padding = padding + 1
		end
	end

	-- add buffer to list of messages
	table.insert(messages, popup)
end

return M
