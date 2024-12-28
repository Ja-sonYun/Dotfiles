local hl = require("highlight")

function GetScrollbar()
	local sbar_chars = { "▇", "▆", "▅", "▄", "▃", "▂", "▁" }

	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
	local sbar = string.rep(sbar_chars[i], 2) -- 선택된 문자를 2번 반복

	return sbar
end

function GetFileInfo()
	-- if buffer has 'info' variable, return it
	if vim.b.info then
		return vim.b.info
	end
	return ""
end

hl.set("Substitute", { ctermfg = "white", ctermbg = "black" })

vim.opt.statusline = "%<%f%h%m%r%{v:lua.GetFileInfo()}%=%b 0x%B %l,%c%V %{v:lua.GetScrollbar()} %P"
