-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------
local auto = require("autocmd")
local is = require("condition")


-- Highlight on yank
auto.group('YankHighlight', { clear = true })
auto.cmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Remove whitespace on save
auto.cmd('BufWritePre', {
  pattern = '',
  callback = function()
    if not is.code() then
      return
    end
    vim.cmd(":%s/\\s\\+$//e")
  end
})

-- Don't auto commenting new lines
auto.cmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})
