nmap w <Plug>CamelCaseMotion_w
vmap w <Plug>CamelCaseMotion_w
nnoremap Q q
nnoremap q <Nop>
nnoremap J <Nop>

" NMAP:
nnoremap ,a :noh <bar> :call EchoMessage('no highlight')<CR>
" nnoremap ,c :TagbarToggle<CR>
nnoremap <silent> ggb :!git branch<CR>
nnoremap <silent> ,x :Tags<CR>
nnoremap <silent> qM :Marks<CR>
nnoremap <silent> qb :Buffers<CR>
nnoremap <silent> gc :Commit<CR>
nnoremap <silent> ,e :TroubleToggle<CR>
nnoremap <silent> ggc :BCommit<CR>
" nnoremap <silent>k,t :Explore<CR>
" nnoremap ,t :NvimTreeToggle<CR>
nnoremap <silent> ,c :TagbarToggle<CR>
nnoremap <silent> ,f :Files<CR>
nnoremap <silent> ,r :Rg<CR>
nnoremap <silent> <leader>q <ESC>:q<CR>
nnoremap <silent> qw <ESC>:w<CR>:call EchoMessage('Saved at ' . strftime('%c'))<CR>
nnoremap <silent> qe <ESC>:e<bar>:LspStop<CR>:sleep 100m<bar>LspStart<CR>:call EchoMessage('Reloaded!')<CR>
nnoremap qr :! 
nnoremap <silent> ql <ESC>:ls<CR>:b 
nnoremap <silent> qm <ESC>:marks<CR>:'
" do noh -> why?
nnoremap <silent> ,R <ESC>:source ~/.mydotfiles/nvim/init.vim <bar> :call EchoMessage('init.vim reloaded!') <bar> :noh<CR>
" nnoremap ;; <ESC>$a;<ESC>
" nnoremap ,, <ESC>$a,<ESC>
" nnoremap WL <ESC>:vertical resize +5<CR>
" nnoremap WH <ESC>:vertical resize -5<CR>
" nnoremap WJ <ESC>:resize +2<CR>
" nnoremap WK <ESC>:resize -2<CR>

nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>
nnoremap <silent> tq :tabclose<CR>
nnoremap <silent> to :tabnew<CR>

" nnoremap <silent> <leader>gy :Goyo<CR>:source ~/.mydotfiles/nvim/init.vim<CR>

" tnoremap <Esc> <C-\><C-n>
" tnoremap <silent> <C-\>t <C-\><C-n>:call TermToggle(10)<CR>
" nnoremap <silent> <C-\>t <ESC>:call TermToggle(10)<CR>
" nnoremap <silent> qt <ESC>:call TermToggle(10)<CR>
" tnoremap <C-h> <C-\><C-N>:call TermToggle(10)<CR><C-w>h
" tnoremap <C-j> <C-\><C-N>:call TermToggle(10)<CR><C-w>j
" tnoremap <silent> <C-k> <C-\><C-N>:call TermToggle(10)<CR><C-w>k
" tnoremap <C-l> <C-\><C-N>:call TermToggle(10)<CR><C-w>l

" nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" for normal mode - the word under the cursor
" for visual mode, the visually selected text
" xmap di <Plug>VimspectorBalloonEval

nmap <silent> qch <ESC>:checkhealth<CR>
nmap <silent> qB <ESC>:BufOnly<CR>
nmap <silent> qR <ESC>:LspStop<CR> :sleep 100m <bar> LspStart<CR>

" Yankround:
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)

xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
" nmap <C-p> <Plug>(yankround-prev)
" nmap <C-n> <Plug>(yankround-next)
"

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering

nnoremap gp :silent %!prettier --stdin-filepath %<CR>

" nnoremap cs :silent *
nnoremap cs *:%s///gc<left><left><left>
vnoremap <C-r> :s/<left>

nnoremap ,,,,i <ESC>:setlocal ts=4 sw=4 expandtab<CR>
nnoremap ,,i <ESC>:setlocal ts=2 sw=2 expandtab<CR>

nnoremap <silent> <leader>ct <cmd>!ctags -R -f .tags<CR>

" autorun
" nmap <leader>qrp :!python %<CR>
imap <silent><script><expr> <C-s> copilot#Accept('\<CR>')

let g:copilot_no_tab_map = v:true
let g:camelcasemotion_key = '<leader>'

