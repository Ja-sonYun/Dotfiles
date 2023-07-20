local M = {}

M.create = vim.api.nvim_create_buf
M.set_lines = vim.api.nvim_buf_set_lines
M.add_highlight = vim.api.nvim_buf_add_highlight

return M
