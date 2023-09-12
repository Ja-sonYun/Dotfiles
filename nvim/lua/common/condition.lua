-----------------------------------------------------
-- Filetype
-----------------------------------------------------
local M = {}

M.code_filetype = {
	"c",
	"cpp",
	"cs",
	"css",
	"go",
	"html",
	"java",
	"js",
	"json",
	"lua",
	"php",
	"svelte",
	"python",
	"rust",
	"sh",
	"sql",
	"swift",
	"toml",
	"ts",
	"tsx",
	"vim",
	"yaml",
	"typescript",
	"javascript",
	"elixir",
	"erlang",
	"haskell",
	"kotlin",
	"perl",
	"ruby",
	"scala",
	"xml",
	"xhtml",
	"scss",
	"dart",
	"heex",
	"terraform",
	"proto",
	"make",
	"terraform-vars",
	"dockerfile",
	"tsx",
	"typescriptreact",
	"javascriptreact",
}
M.non_code_buftype = {
	"nofile",
	"prompt",
	"terminal",
	"acwrite",
}

M.code = function()
	for _, v in pairs(M.non_code_buftype) do
		if vim.bo.buftype == v then
			return false
		end
	end

	local is_ok = false
	for _, v in pairs(M.code_filetype) do
		if vim.bo.filetype == v then
			is_ok = true
			break
		end
	end
	return is_ok
end

return M
