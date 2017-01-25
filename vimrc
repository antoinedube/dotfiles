set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'morhetz/gruvbox'
    Plugin 'veloce/vim-behat'
    Plugin 'tpope/vim-fugitive'
    Plugin 'kchmck/vim-coffee-script'
call vundle#end()

set fileencodings=utf-8

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set smarttab
set showcmd
set number
set showmatch
set hlsearch
set incsearch
set smartcase
set wildignorecase
set wildmenu
set backspace=2
set autoindent
set textwidth=230
set formatoptions=c,q,r,t
set ruler
set background=dark

set noshowmode
let g:bufferline_echo = 0
set laststatus=2
let g:Powerline_symbols = 'unicode'

set timeoutlen=50

set nobackup
set nowritebackup
set noswapfile
set cursorline

set scrolloff=10

set tabpagemax=50

set t_Co=256

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

map <F9> :tabp <CR>
map <F10> :tabn <CR>

map <F11> :cp <CR>
map <F12> :cn <CR>

set complete=.,w,b,u,U,t,i,d
set completeopt=menu

filetype plugin indent on
filetype plugin on

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

autocmd BufWritePre * :%s/\s\+$//e

syntax on

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:airline_theme='gruvbox'


:command -nargs=1 Icppclass :normal i
    \class <args> {<CR>
    \  public:<CR>
    \    <args>();<CR>
    \virtual ~<args>();<CR>
    \<BS><BS>  private:<CR>
    \<BS>};<CR>
    \<ESC><Right>xxx

:command -nargs=1 Itags :normal i<<args>></<args>><CR><ESC>xx

