lua << EOF
require'nvim-tree'.setup {
  auto_reload_on_write = true,
  hijack_netrw = true,
  view = {
    side = "left"
  }
}
EOF


let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }
let g:nvim_tree_icons = {
    \ 'default': '- ',
    \ 'symlink': '&',
    \ 'git': {
    \   'unstaged': "x",
    \   'staged': "s",
    \   'unmerged': ".",
    \   'renamed': "m",
    \   'untracked': "?",
    \   'deleted': "!",
    \   'ignored': "_"
    \   },
    \ 'folder': {
    \   'arrow_open': "└",
    \   'arrow_closed': "|",
    \   'default': "=",
    \   'open': "┐",
    \   'empty': "-",
    \   'empty_open': "+",
    \   'symlink': "&",
    \   'symlink_open': "&",
    \   }
    \ }

augroup nvim_tree_augroup
  autocmd!
  autocmd BufEnter * if &filetype == 'NvimTree' | set cursorline | endif
  autocmd BufLeave * if &filetype == 'NvimTree' | exec "NvimTreeClose" | endif
augroup END

nnoremap <silent> ,t :NvimTreeToggle<CR>
" nnoremap <silent> ,t :call Explorer()<CR>

" let g:netrw_use_noswf = 0
" " let g:netrw_banner = 0
" let g:netrw_liststyle = 3

" let g:netrw_opened = 0
" let g:netrw_prev_buffer_id = 0

" function! Explorer()
"   if g:netrw_opened == 0
"     let g:netrw_prev_buffer_id = bufnr("")
"     exec "Explore"
"     let g:netrw_opened = 1
"   else
"     try
"       exec ":buffer ".g:netrw_prev_buffer_id
"     catch
"       exec "close"
"     endtry
"     let g:netrw_prev_buffer_id = 0
"     let g:netrw_opened = 0
"   endif
" endfunction

" augroup netrw_mapping
"   autocmd!
"   autocmd filetype netrw call NetrwMapping()
"   autocmd BufLeave * if &filetype == 'netrw' | call Explorer() | endif
" augroup END

" function! NetrwMapping()
"   noremap <buffer><silent> <C-h> :TmuxNavigateLeft<cr>
"   noremap <buffer><silent> <C-j> :TmuxNavigateDown<cr>
"   noremap <buffer><silent> <C-k> :TmuxNavigateUp<cr>
"   noremap <buffer><silent> <C-l> :TmuxNavigateRight<cr>
"   noremap <buffer><silent> <nowait> q :call Explorer()<cr>
"   noremap <buffer><silent> <C-o> :call Explorer()<cr>
"   noremap <buffer><silent> ,t :call Explorer()<cr>
"   noremap <buffer> a <nop>
"   noremap <buffer> n %
"   " nnoremap <silent> < :TmuxNavigatePrevious<cr>
" endfunction
