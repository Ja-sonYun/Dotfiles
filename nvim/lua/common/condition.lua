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
  "pbtxt",
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
  "hcl",
	-- "markdown",
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

M.non_code = {
	"*.so",
	"*.o",
	"*.obj",
	"*.dylib",
	"*.bin",
	"*.dll",
	"*.exe",
	"*/.git/**",
	"*/.svn/**",
	"*/.venv/**",
	"*/__pycache__/*",
	"*/build/**",
	"*.jpg",
	"*.png",
	"*.jpeg",
	"*.bmp",
	"*.gif",
	"*.tiff",
	"*.svg",
	"*.ico",
	"*.pyc",
	"*.pkl",
	"*.DS_Store",
	"*.aux",
	"*.bbl",
	"*.blg",
	"*.brf",
	"*.fls",
	"*.fdb_latexmk",
	"*.synctex.gz",
	"*.xdv",
}

return M
