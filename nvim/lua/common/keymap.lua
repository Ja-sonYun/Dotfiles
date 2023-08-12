-----------------------------------------------------
-- Keymapper
-----------------------------------------------------
local M = {}

M.u = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	if type(rhs) == "function" then
		vim.keymap.set(mode, lhs, rhs, options)
	else
		vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	end
end

M.n = function(lhs, rhs, opts)
	M.map("n", lhs, rhs, opts)
end

M.v = function(lhs, rhs, opts)
	M.map("v", lhs, rhs, opts)
end

M.i = function(lhs, rhs, opts)
	M.map("i", lhs, rhs, opts)
end

M.t = function(lhs, rhs, opts)
	M.map("t", lhs, rhs, opts)
end

buf = {}

buf.map = function(mode, lhs, rhs, bufnr_or_opts, opts)
	local options = { silent = true }
	local bufnr = 0

	if type(bufnr_or_opts) == "table" then
		options = vim.tbl_extend("force", options, bufnr_or_opts)
	else
		bufnr = bufnr_or_opts or 0
	end
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	if type(rhs) == "function" then
		options = vim.tbl_extend("force", { buffer = bufnr }, options)
		vim.keymap.set(mode, lhs, rhs, options)
	else
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
	end
end

buf.n = function(lhs, rhs, bufnr_or_opts, opts)
	buf.map("n", lhs, rhs, bufnr_or_opts, opts)
end

buf.v = function(lhs, rhs, bufnr_or_opts, opts)
	buf.map("v", lhs, rhs, bufnr_or_opts, opts)
end

buf.i = function(lhs, rhs, bufnr_or_opts, opts)
	buf.map("i", lhs, rhs, bufnr_or_opts, opts)
end

buf.t = function(lhs, rhs, bufnr_or_opts, opts)
	buf.map("t", lhs, rhs, bufnr_or_opts, opts)
end

M.buf = buf

return M
