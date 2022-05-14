"============================================
"WIP
" nmap qa :call RegisterTermCmdBuf()<CR>

" function! RegisterTermCmdBuf()
"   " let a:last_macro = input("Macro: ")
"   let g:cmd = input("Command: ")
"   let @r="qt " . g:cmd
" endfunction

" nnoremap qa :let @r=qt <CR>

" let g:last_macro = ""
" function! OpenMacroBuf()
"   let g:last_macro = input("Macro: ")
"   if g:last_macro != ""
"     botright 2new
"     call feedkeys('"' . g:last_macro . 'p')
"     imap <buffer> <ESC> <C-[>:call feedkeys('"' . g:last_macro . "yy")<CR>:q!<CR>
"   endif
" endfunction
"============================================
 " hello
 "

function! ShowInfo(msg)
  echohl MoreMsg
  echon a:msg
  echohl None
endfunction

function! ShowWarn(msg)
  echohl SpecialKey
  echon a:msg
  echohl None
endfunction

" echoing message
function! EchoMessage(msg)
  echohl WarningMsg
  echo "Message"
  echohl None
  echon ': ' a:msg
endfunction

" Terminal Function
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
  " let g:is_small_term_open = 1
  if win_gotoid(g:term_win)
    hide
  else
    botright split
    " exec "split"
    exec "resize " . a:height
    try
      exec "buffer " . g:term_buf
    catch
      exec "terminal"
      let g:term_buf = bufnr("")
      set nonumber
      set norelativenumber
      set signcolumn=no
    endtry
    startinsert!
    let g:term_win = win_getid()
  endif
endfunction

" https://github.com/dohsimpson/vim-macroeditor
"  Original source code
function! YankToRegister()
  exe printf('norm! ^"%sy$', b:registername)
endfunction

function! OpenMacroEditorWindow(registername)
  let name = 'MacroEditor'
  if bufexists(name)
    echohl WarningMsg
    echom "One macro at a time:)"
    echohl None
    let win = bufwinnr(name)
    exe printf('%d . wincmd w', win)
    return
  endif
  botright new name
  exec "resize 3"
  let b:registername = a:registername
  setlocal bufhidden=wipe noswapfile nobuflisted
  exe printf('norm! "%sp', b:registername)
  set nomodified
  augroup MacroEditor
    au!
    au BufWriteCmd <buffer> call YankToRegister()
    au BufWriteCmd <buffer> set nomodified
  augroup END
  nmap <buffer><C-k> :wq!<CR>
  nmap <buffer><ESC> :wq!<CR>
endfunction
command! -nargs=1 MacroEdit call OpenMacroEditorWindow("<args>")
nnoremap ,@ :MacroEdit 


nmap <buffer>qnt :call TimeLine()<CR>
nmap <buffer>qnv :call VerticalLine()<CR>
nmap <buffer>qnc :call MarkTodo()<CR>
nmap <buffer>qnda i↓ <ESC>

function! TimeLine()
  let l:from = input("from: ")
  let l:to = input("to: ")
  let l:memo = input("memo: ")
  call feedkeys("g0i")"
  call feedkeys("╒═══════════════╕\n")
  call feedkeys("│ " . l:from . " ~ " . l:to . " ╵\n")
  call feedkeys("│ " . l:memo . "\n")
  call feedkeys("╰───────────────╯\n\<ESC>k^")
endfunction

function! VerticalLine()
  call feedkeys("o\<ESC>g0i╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌\<ESC>^")"
endfunction

function! MarkTodo()
  let l:line = getline('.')
  if stridx(l:line, " - [ ] ") == 0
    call feedkeys(":s/ \- \\[ \\] / \- \\[x\\] /g | noh\<CR>$")
    echom "Marked as done"
  else
    call feedkeys(":s/ \- \\[x\\] / \- \\[ \\] /g | noh\<CR>$")
    echom "Marked as unfinished"
  endif
endfunction

" function! MarkTodo()
" endfunction
