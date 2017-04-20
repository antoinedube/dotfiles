call plug#begin('~/.vim/plugged')
    Plug 'carlitux/deoplete-ternjs'
    Plug 'freeo/vim-kalisi'
    Plug 'jiangmiao/auto-pairs'
    Plug 'morhetz/gruvbox'
    Plug 'mtscout6/syntastic-local-eslint.vim'
    Plug 'mxw/vim-jsx'
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'tpope/vim-fugitive'
    Plug 'udalov/kotlin-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-syntastic/syntastic'
    Plug 'zchee/deoplete-clang'
    Plug 'zchee/deoplete-jedi'
call plug#end()

set autoindent
set background=dark
set backspace=2
set complete=.,w,b,u,U,t,i,d
set completeopt=menu
set cursorline
set expandtab
set fileencodings=utf-8
set formatoptions=c,q,r,t
set hlsearch
set incsearch
set nobackup
set noshowmode
set noswapfile
set nowritebackup
set number
set ruler
set scrolloff=10
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=4
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{SyntasticStatuslineFlag()}
set t_Co=256
set tabpagemax=50
set tabstop=4
set textwidth=230
set timeoutlen=50
set wildignorecase
set wildmenu

map <F9> :tabp <CR>
map <F10> :tabn <CR>

map <F11> :cp <CR>
map <F12> :cn <CR>

filetype plugin indent on
filetype plugin on

autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype ruby setlocal ts=4 sts=4 sw=4

autocmd BufWritePre * :%s/\s\+$//e

syntax on

colorscheme kalisi

let g:jsx_ext_required=0

let g:airline_theme='kalisi'
let g:airline_powerline_fonts=1

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'
let g:deoplete#sources#clang#std={'c': 'c11', 'cpp': 'c++11'}
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete_start_length=1
let g:deoplete#auto_complete_delay=25

let g:jedi#popup_select_first=1

let g:tern_request_timeout=1
let g:tern_show_signature_in_pum='0'
let g:tern#filetypes=['js', 'jsx']

let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_javascript_checkers = ['eslint']

