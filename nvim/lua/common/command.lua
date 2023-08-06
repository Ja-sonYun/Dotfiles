local M = {}

M.new = function(name, func, opts)
  local opts = opts or {}
  vim.api.nvim_create_user_command(name, func, opts)
end

-- Run current file
M.shell_cf = function(name, cmds)
  M.new(name, function()
    for _, cmd in ipairs(cmds) do
      local string = '!' .. cmd .. ' ' .. vim.fn.expand('%')
      vim.cmd(string)
    end
    vim.cmd('edit!')
    vim.cmd('write')
  end, {nargs = 0})
end

M.shell = function(name, cmd)
  M.new(name, function()
    vim.cmd(cmd)
  end, {nargs = 0})
end

return M
