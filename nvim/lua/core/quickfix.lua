local map = require('keymap')
local auto = require('autocmd')

-- Quickfix, quit with q
auto.while_win('Quickfix', 'qf', {
  on_load = function(opts)
    vim.opt_local.number = false
    vim.opt_local.cursorline = true
    vim.opt_local.statusline = '%n %f%=%L lines'

    map.buf.n('q', ':q<CR>', opts.buffer, { nowait = true })
    map.buf.n('<C-c>', ':q<CR>', opts.buffer, { nowait = true })
  end,
  on_close = function()
    -- vim.opt.laststatus = 2
  end
})

auto.cmd('QuickFixCmdPost', {
  pattern = '*',
  command = 'copen',
})
