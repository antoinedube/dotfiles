set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'bling/vim-airline'
    Plugin 'Rip-Rip/clang_complete'
    Plugin 'sjl/badwolf'
    Plugin 'Valloric/MatchTagAlways'
    Plugin 'scrooloose/nerdtree'
    Plugin 'suan/vim-instant-markdown'
    Plugin 'hallison/vim-darkdevel'
    Plugin 'veloce/vim-behat'
    Plugin 'tpope/vim-fugitive'
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
set textwidth=160
set formatoptions=c,q,r,t
set ruler
set background=dark

set noshowmode
let g:bufferline_echo = 0
set laststatus=2
let g:airline_theme = 'badwolf'
let g:Powerline_symbols = 'unicode'

set timeoutlen=50

set nobackup
set nowritebackup
set noswapfile
set cursorline

let c_space_errors = 1
let c_comment_strings = 1

let g:clang_complete_copen=1
let g:clang_hl_errors=1

let g:clang_library_path = '/usr/lib/'

set tabpagemax=50

"set t_Co=256

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

colorscheme darkdevel

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

syntax on

:command -nargs=1 Icppclass :normal i
    \class <args> {<CR>
    \  public:<CR>
    \    <args>();<CR>
    \virtual ~<args>();<CR>
    \<BS><BS>  private:<CR>
    \<BS>};<CR>
    \<ESC><Right>xxx

:command -nargs=1 Itags :normal i<<args>></<args>><CR><ESC>xx


