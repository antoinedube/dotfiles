call plug#begin('~/.vim/plugged')
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'benjie/neomake-local-eslint.vim'
    Plug 'carlitux/deoplete-ternjs'
    Plug 'freeo/vim-kalisi'
    Plug 'jiangmiao/auto-pairs'
    Plug 'morhetz/gruvbox'
    Plug 'mxw/vim-jsx'
    Plug 'neomake/neomake'
    Plug 'saltstack/salt-vim'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
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
set relativenumber
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

autocmd BufWritePre * :%s/\s\+$//e
autocmd! BufReadPost * Neomake
autocmd! BufWritePost * Neomake

syntax on

colorscheme gruvbox

let g:jsx_ext_required=0

let g:airline_theme='gruvbox'
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

let g:neomake_python_enabled_makers=['flake8']
let g:neomake_javascript_enabled_makers=['eslint']
let g:neomake_c_enabled_makers=['gcc']
let g:neomake_json_enabled_makers=['jsonlint']

let g:neomake_c_gcc_maker={
            \'exe': 'gcc',
            \'args': [
            \ '-fsyntax-only',
            \ '-std=c11',
            \ '-Wall',
            \ '-Wextra',
            \ '-pedantic',
            \ '-I.',
            \ ],
    \ }


