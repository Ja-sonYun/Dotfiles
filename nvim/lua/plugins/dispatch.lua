return {
  {
    'tpope/vim-dispatch',
    init = function()
      local auto = require("autocmd")

      auto.cmd('Filetype', {
        pattern = 'python',
        command = "let b:dispatch = 'poetry run python %'"
      })
    end,
  },
}
