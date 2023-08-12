-----------------------------------------------------
-- Autocmd
-----------------------------------------------------
local M = {}

M.group = vim.api.nvim_create_augroup
M.cmd = vim.api.nvim_create_autocmd

M.while_win = function(name, pattern, func_map)
	M.group(name, { clear = true })
	M.cmd("FileType", {
		group = name,
		pattern = pattern,
		callback = function(opts)
			local winid = vim.api.nvim_get_current_win()
			func_map.on_load(opts)
			M.cmd("WinClosed", {
				group = name,
				pattern = tostring(winid),
				callback = function(opts)
					func_map.on_close(opts)
				end,
			})
		end,
	})
end

M.augcmd = function(name, event, pattern_or_callback, callback)
	if type(pattern_or_callback) == "function" then
		callback = pattern_or_callback
		pattern_or_callback = "*"
	end
	M.group(name, { clear = true })
	M.cmd(event, {
		group = name,
		pattern = pattern,
		callback = callback,
	})
end

M.rmaug = function(name)
	M.group(name, { clear = true })
end

return M
