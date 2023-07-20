local map = require("keymap")

map.n('@', 'q')
map.n('q', '@')
map.n('qq', '@@')
map.n('~', 'Q')
map.n('Q', ':MacroEdit<CR>')

vim.cmd[[
  function! YankToRegister()
    exe printf('norm! ^"%sy$', b:registername)
  endfunction

  function! OpenMacroEditorWindow()
    let registername = nr2char(getchar())
    let name = 'MacroEditor'
    if bufexists(name)
      echohl WarningMsg
      echom "One macro at a time:)"
      echohl None
      let win = bufwinnr(name)
      exe printf('%d . wincmd w', win)
      return
    endif
    let height = 3
    execute height 'new ' name
    let b:registername = registername
    setlocal bufhidden=wipe noswapfile nobuflisted
    exe printf('norm! "%sp', b:registername)
    set nomodified
    augroup MacroEditor
      au!
      au BufWriteCmd <buffer> call YankToRegister()
      au BufWriteCmd <buffer> set nomodified
    augroup END
  endfunction
  command! MacroEdit call OpenMacroEditorWindow()
]]
