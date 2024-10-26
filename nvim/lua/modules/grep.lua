local M = {}

M.Grep = function(text)
	local suffix = vim.b.file_suffix
	-- Connect suffix to text with a wildcard
	for i, s in ipairs(suffix) do
		suffix[i] = "**/*" .. s
	end
	suffix_text = table.concat(suffix, ",")
	vim.cmd("vimgrep /" .. text .. "/j " .. suffix_text)
	vim.cmd("copen")
end

return M
