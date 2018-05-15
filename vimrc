call plug#begin('~/.vim/plugged')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'jiangmiao/auto-pairs'
    Plug 'maralla/completor.vim'
    Plug 'antoinedube/harlequin'
    Plug 'mxw/vim-jsx'
    Plug 'saltstack/salt-vim'
    Plug 'stephpy/vim-yaml'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-syntastic/syntastic'
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
set listchars=space:·,trail:~,tab:>- " eol character is disabled
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
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{SyntasticStatuslineFlag()}
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

map <F9> :tabp <CR>
map <F10> :tabn <CR>

map <F11> :cp <CR>
map <F12> :cn <CR>

filetype plugin indent on
filetype plugin on

autocmd BufWritePre * :%s/\s\+$//e

syntax enable

colorscheme harlequin

let g:jsx_ext_required=0

let g:airline_theme = 'molokai'
let g:airline_powerline_fonts=1

let g:jedi#show_call_signatures = "0"

let g:completor_python_binary = '/usr/bin/python'
let g:completor_node_binary = '/usr/bin/node'
let g:completor_clang_binary = '/usr/bin/clang'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_w = 1
let g:syntastic_auto_jump = 0

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<tab>'

let g:UltiSnipsSnippetDirectories = ['/home/antoine/.vim/UltiSnips', '/home/antoine/.vim/plugged/vim-snippets/UltiSnips']
