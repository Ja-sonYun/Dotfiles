local M = {}

M.Grep = function(text)
	local pattern = text:gsub('"', '\\"')
	local cmd = 'rg --vimgrep --hidden --glob "!.git" "' .. pattern .. '"'

	local result = vim.fn.systemlist(cmd)

	if vim.v.shell_error ~= 0 then
		print("Error executing rg: " .. table.concat(result, "\n"))
		return
	end

	vim.fn.setqflist({}, "r", { title = "Search Results", lines = result })
	vim.cmd("copen")
end

return M
