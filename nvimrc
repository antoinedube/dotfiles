call plug#begin('~/.nvim/plugged')
    Plug 'jiangmiao/auto-pairs'
    Plug 'stephpy/vim-yaml'
    Plug 'preservim/nerdtree'

    Plug 'cloudhead/neovim-fuzzy' " Fuzzy file finder

    " Usage: :Ag [pattern]
    " will search in current directory
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'
    Plug 'danilo-augusto/vim-afterglow'
    Plug 'navarasu/onedark.nvim'

    Plug 'onsails/lspkind.nvim'
    Plug 'neovim/nvim-lspconfig'
    " https://github.com/neovim/nvim-lspconfig
    " https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " Plug 'simrat39/rust-tools.nvim'
call plug#end()

set autoindent
set background=dark
set backspace=2
set complete=.,w,b,u,t
set completeopt=menuone,noinsert
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
" set wildmenu
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

" Open new tab
nnoremap <C-t> :tabnew <CR>

" Open fuzzy finder
" https://github.com/cloudhead/neovim-fuzzy/issues/50
let g:fuzzy_rootcmds = [ ["git", "rev-parse", "--show-toplevel"], ]
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

let g:onedark_config = {
    \ 'style': 'darker',
\}
colorscheme onedark
" colorscheme gruvbox
" colorscheme afterglow

let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1
" let g:gruvbox_contrast_dark = 'hard'

" let g:deoplete#enable_at_startup = 1
" let g:neomake_python_enabled_makers = ['flake8']

lua <<EOF
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig/configs'

    local cmp = require 'cmp'

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
        })
    })

    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- local opts = { noremap=true, silent=true }
    -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    end


    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp_flags = { debounce_text_changes = 150 }

    lspconfig['bashls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }

    lspconfig['pyright'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }

    -- Ref: https://github.com/joe-re/sql-language-server
    lspconfig['sqlls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern '.sqllsrc.json'
    }

    lspconfig['tsserver'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json")
    }

    lspconfig['denols'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    }

    lspconfig['rust_analyzer'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        -- Server-specific settings...
        settings = {
          ["rust-analyzer"] = {}
        }
    }

    -- Ref: https://github.com/redhat-developer/yaml-language-server
    -- lspconfig['yamlls'].setup{
    --     on_attach = on_attach,
    --     flags = lsp_flags,
    --     capabilities = capabilities,
    --     settings = {
    --         yaml = {
    --             schemas = {
    --                 ["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible.json"] = "playbooks/*.yaml"
    --             }
    --         }
    --     }
    -- }

    lspconfig['ansiblels'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { 'ansible-language-server', '--stdio' },
        filetypes = { 'yaml' },
        root_dir = lspconfig.util.root_pattern 'ansible.cfg',
        settings = {
            ansible = {
                ansible = {
                    path = "ansible"
                },
                ansibleLint = {
                    enabled = true,
                    path = "ansible-lint"
                },
                executionEnvironment = {
                    enabled = false
                },
                python = {
                    interpreterPath = "python"
                }
            }
        }
    }

    lspconfig['groovyls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { "java", "-jar", "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" }
    }
EOF
