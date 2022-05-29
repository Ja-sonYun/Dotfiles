" Plugins by Vundle

set nocompatible
filetype off

set rtp+=$MYDOTFILES/nvim/bundle/Vundle.vim
call vundle#begin()            " required
Plugin 'VundleVim/Vundle.vim'  " required
" Vim FZf integration, used as OmniSharp selector
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Plugin 'chrisbra/csv.vim'
Plugin 'github/copilot.vim'
Plugin 'puremourning/vimspector'
Plugin 'tpope/vim-fugitive'
Plugin 'simeji/winresizer'
Plugin 'majutsushi/tagbar'
Plugin 'chrisbra/unicode.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'schickling/vim-bufonly'
Plugin 'vim-scripts/DrawIt'
Plugin 'tpope/vim-repeat'
Plugin 'surround.vim'
Plugin 'mattn/emmet-vim'
Plugin 'LeafCage/yankround.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'drzel/vim-line-no-indicator'
Plugin 'bkad/CamelCaseMotion'
Plugin 'airblade/vim-rooter'
Plugin 'Yggdroot/indentLine'

if has('nvim')
  " Plugin 'ldelossa/litee.nvim'
  " Plugin 'ldelossa/gh.nvim'
  Plugin 'lewis6991/gitsigns.nvim'
  Plugin 'folke/trouble.nvim'
  Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Plugin 'romgrk/nvim-treesitter-context'
  Plugin 'norcalli/nvim-colorizer.lua'
  Plugin 'nvim-lua/plenary.nvim'
  " Plugin 'folke/todo-comments.nvim'
  " Plugin 'gelguy/wilder.nvim'
  Plugin 'ms-jpq/coq_nvim', {'branch': 'coq'}
  " Plugin 'ggandor/lightspeed.nvim'
  Plugin 'neovim/nvim-lspconfig'
  Plugin 'j-hui/fidget.nvim'
  Plugin 'kyazdani42/nvim-tree.lua'
  Plugin 'MunifTanjim/nui.nvim'
  " Plugin 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python -m chadtree deps'}
  " Plugin 'rcarriga/nvim-notify'
  Plugin 'pwntester/octo.nvim'
  Plugin 'nvim-telescope/telescope.nvim'
  Plugin 'kyazdani42/nvim-web-devicons'
  Plugin 'vimwiki/vimwiki'
  Plugin 'tools-life/taskwiki'
endif


call vundle#end()               " required
filetype plugin indent on       " required
syntax on

" plugin development

set runtimepath^=~/.vim/bundle/test.nvim
