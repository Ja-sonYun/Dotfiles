-----------------------------------------------------
-- Highlight
-----------------------------------------------------
local M = {}

M.set = function(group, styles)
  vim.api.nvim_set_hl(0, group, styles)
end

M.link = function(group, link_to)
  vim.api.nvim_set_hl(0, group, { link = link_to })
end

return M
