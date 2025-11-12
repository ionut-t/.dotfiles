""" Basic vimrc configuration for macOS
" This is a starter configuration with commonly used settings.
" Lines starting with double quotes (") are comments.

""" General Settings
set nocompatible          " Don't be compatible with vi
syntax enable             " Enable syntax highlighting
set encoding=utf-8        " Use UTF-8 encoding
set number                " Show line numbers
set ruler                 " Show cursor position
set showcmd               " Show incomplete commands
set showmode              " Show current mode
set wildmenu              " Enhanced command line completion
set laststatus=2          " Always show status line
set backspace=indent,eol,start  " Make backspace work like most other apps

""" Search Settings  
set incsearch             " Incremental search (as you type)
set hlsearch              " Highlight search results
set ignorecase            " Case-insensitive search...
set smartcase             " ...unless search contains uppercase

""" Indentation and Tabs
set autoindent            " Auto-indent new lines
set smartindent           " Smart indent
set smarttab              " Smart handling of the tab key
set shiftwidth=4          " Number of spaces for auto-indentation
set tabstop=4             " Number of spaces a tab counts for
set softtabstop=4         " Number of spaces tab counts for while editing
set expandtab             " Use spaces instead of tabs

""" Visual Settings
set showmatch             " Show matching brackets
set wrap                  " Wrap lines
set linebreak             " Break lines at word boundaries
set scrolloff=3           " Keep 3 lines visible when scrolling

""" Mouse Support
set mouse=a               " Enable mouse in all modes

""" File Handling
set autoread              " Automatically read files changed outside of Vim
set hidden                " Allow hidden buffers
set nobackup              " Don't create backup files
set noswapfile            " Don't create swap files

""" Key Mappings
" Use jk to exit insert mode (faster than reaching for Escape)
inoremap jk <Esc>

" Faster navigation between split windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Toggle line numbers with \n
nnoremap <leader>n :set number!<CR>

" Clear search highlighting with \<space>
nnoremap <leader><space> :nohlsearch<CR>

""" macOS specific settings
" Copy to system clipboard
set clipboard=unnamed

""" Colors
" Enable 256 colors in terminal
set t_Co=256
set termguicolors       " Enable true color support

" If you want to use a color scheme, uncomment one of these:
" colorscheme desert
" colorscheme solarized
" colorscheme molokai
" Note: You may need to install these color schemes separately

""" File type specific settings
" Enable file type detection
filetype on
filetype plugin on
filetype indent on

" Custom settings for specific file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4

""" Golang specific settings
autocmd FileType go setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
" Go uses tabs, not spaces
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8

" Automatic imports formatting for Go
autocmd BufWritePre *.go :%s/\s\+$//e  " Remove trailing whitespace on save
" Highlight Go code
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Plugins

""" Plugin Management with vim-plug
" Automatically install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin list
call plug#begin('~/.vim/plugged')
  " Catppuccin theme
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }

Plug 'tpope/vim-eunuch'
call plug#end()

" Set colorscheme after plugins are loaded
colorscheme catppuccin_mocha

