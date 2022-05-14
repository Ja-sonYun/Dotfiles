" vimspector

function! SetVimspectorKeyMapping()
  nnoremap <silent> qdc <Plug>VimspectorContinue
  nnoremap <silent> qdf <Plug>VimspectorAddFunctionBreakpoint
  nnoremap <silent> qdT <Plug>VimspectorToggleConditionalBreakpoint
  nnoremap <silent> qdr <Plug>VimspectorRestart
  nnoremap <silent> qdp <Plug>VimspectorPause
  nnoremap <silent> qdW :VimspectorWatch
  nnoremap <silent> qdk <Plug>VimspectorBalloonEval
  nnoremap <silent> qdC :call vimspector#ClearBreakpoints()<CR>
endfunction

function! UnSetVimspectorKeyMapping()
  nnoremap qdc <nop>
  nnoremap qdf <nop>
  nnoremap qdT <nop>
  nnoremap qdr <nop>
  nnoremap qdp <nop>
  nnoremap qdW <nop>
  nnoremap qdk <nop>
  nnoremap qdC <nop>
endfunction

let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB', 'vscode-node' ]
let g:vimspector_enable_mapping = 'HUMAN'
let g:vimspector_variables_display_mode = 'full'

let g:vimspector_on = 0
function! ToggleVimspector()
  if g:vimspector_on == 1
    exec "VimspectorReset"
    let g:vimspector_on = 0
    call EchoMessage("Vimspector Quited")
    augroup VimspectorKeyMap
      autocmd!
    augroup END
    call UnSetVimspectorKeyMapping()
  else
    let l:vimspector_status = execute("normal \<Plug>VimspectorRestart")
    if len(l:vimspector_status) == 0
      let g:vimspector_on = 1
      augroup VimspectorKeyMap
        autocmd!
        autocmd BufEnter * call SetVimspectorKeyMapping()
        autocmd BufLeave * call UnSetVimspectorKeyMapping()
      augroup END
      call SetVimspectorKeyMapping()
    else
      let g:vimspector_on = 0
      call EchoMessage(l:vimspector_status)
    endif
  endif
endfunction

let g:vimspector_sign_priority = {
  \    'vimspectorBP':         13,
  \    'vimspectorBPCond':     12,
  \    'vimspectorBPLog':      12,
  \    'vimspectorBPDisabled': 11,
  \    'vimspectorPC':         999,
  \ }

nmap qdd :call ToggleVimspector()<CR>
nmap <silent> qdt <Plug>VimspectorToggleBreakpoint
nmap <silent> qdb <Plug>VimspectorBreakpoints
