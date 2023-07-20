local auto = require("autocmd")

-- Open a Terminal on the right tab
auto.cmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
auto.cmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

auto.cmd('BufEnter', {
  pattern = 'term://*',
  command = 'startinsert'
})

auto.cmd('BufLeave', {
  pattern = 'term://*',
  callback = function()
    pcall(vim.cmd, 'norm G')
    pcall(vim.cmd, 'stopinsert')
  end
})
