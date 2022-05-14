set termguicolors
let s:using_snippets = 0

source $MYDOTFILES/nvim/$OS_ENV/host.vim
source $MYDOTFILES/nvim/$OS_ENV/plugins.vim
luafile $MYDOTFILES/nvim/base/lua_plugins_setups.lua
source $MYDOTFILES/nvim/$OS_ENV/clipboard.vim

source $MYDOTFILES/nvim/base/debugger.vim
source $MYDOTFILES/nvim/base/indent.vim
source $MYDOTFILES/nvim/base/statusline.vim
luafile $MYDOTFILES/nvim/base/lsp.lua
source $MYDOTFILES/nvim/base/tree.vim
source $MYDOTFILES/nvim/base/treesitter.vim
source $MYDOTFILES/nvim/base/mapping.vim
source $MYDOTFILES/nvim/base/autocmd.vim
source $MYDOTFILES/nvim/base/vimrooter.vim
source $MYDOTFILES/nvim/base/theme.vim
source $MYDOTFILES/nvim/base/custom.vim

luafile $MYDOTFILES/nvim/base/lua_custom.lua

set encoding=UTF-8
scriptencoding utf-8
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=-1
set tabstop=8
set title
set regexpengine=1
set noshowcmd
set nocursorline
set hidden
set nofixendofline
set nostartofline
set splitbelow
set splitright
set hlsearch
set incsearch
set re=0
" set showtabline=2
" set signcolumn=number
set signcolumn=number
set completeopt=menu,menuone,noselect

set shortmess+=c
set termguicolors

set noruler
set noshowmode
set updatetime=1000
set timeoutlen=1000
set ttimeoutlen=0
set tags=./.tags;,tags;
set foldenable
set foldmethod=manual

set nu
set relativenumber

set backupcopy=yes  " this shit makes trunk fucking blind

" open all fold
set foldlevel=99

let g:fzf_tags_command = 'ctags -R -f .tags'

" if exists('+termguicolors')
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif

" let g:airline#extensions#tabline#enabled = 1

" NerdCommenter:
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'


" Custom Key Mapping:
" nnoremap <C-p> :Files<CR>
" nnoremap <C-n> :Rg<CR>
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
