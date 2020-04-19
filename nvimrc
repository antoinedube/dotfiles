call plug#begin('~/.nvim/plugged')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'cloudhead/neovim-fuzzy'
    Plug 'jiangmiao/auto-pairs'
    Plug 'morhetz/gruvbox'
    Plug 'neomake/neomake'
    Plug 'stephpy/vim-yaml'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'preservim/nerdtree'
call plug#end()

set autoindent
set background=dark
set backspace=2
set complete=.,w,b,u,U,t,i,d
set completeopt=menu,noinsert
set cursorline
set expandtab
set fileencodings=utf-8
set formatoptions=c,q,r,t
set hlsearch
set incsearch
set listchars=trail:~,tab:>- " eol character is disabled
set list
set linebreak
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
set t_Co=256
set tabpagemax=50
set tabstop=4
set textwidth=0
set timeoutlen=50
set wildignorecase
set wildmenu
set wrap
set wrapmargin=0

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Open fuzzy finder
nnoremap <C-p> :FuzzyOpen <CR>

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" previous/next tab
map <F9> :tabp <CR>
map <F10> :tabn <CR>

filetype plugin indent on
filetype plugin on

autocmd BufWritePre * :%s/\s\+$//e
autocmd Filetype go setlocal ai ts=4 sw=4 noet
autocmd BufWinEnter,BufWritePost *.c :Neomake gcc

syntax enable

colorscheme gruvbox

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts=1
let g:gruvbox_contrast_dark = 'medium'

" When writing a buffer (no delay).
call neomake#configure#automake('nrwi', 500)

let g:c_syntax_for_h=1

let g:deoplete#enable_at_startup = 1
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_cpp_enabled_makers = ['gcc']

let g:neomake_gcc_args=[
    \ '-fsyntax-only',
    \ '-std=c11',
    \ '-Wall',
    \ '-Wextra',
    \ '-I.',
    \ '-I./src',
    \ ]

