call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'zchee/deoplete-clang'
    Plug 'zchee/deoplete-jedi'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'freeo/vim-kalisi'
    Plug 'carlitux/deoplete-ternjs'
    Plug 'vim-syntastic/syntastic'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-fugitive'
call plug#end()

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

set timeoutlen=50

set nobackup
set nowritebackup
set noswapfile
set cursorline

set scrolloff=10

set tabpagemax=50

set t_Co=256

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

colorscheme kalisi
let g:airline_theme='kalisi'

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'
let g:deoplete#sources#clang#std={'c': 'c11', 'cpp': 'c++11'}
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete_start_length=1

let g:jedi#popup_select_first=1

let g:tern_request_timeout=1
let g:tern_show_signature_in_pum='0'
let g:tern#filetypes=['js', 'jsx']

let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_c_checkers = ['gcc']

