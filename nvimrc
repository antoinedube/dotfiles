call plug#begin('~/.nvim/plugged')
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'

    Plug 'cloudhead/neovim-fuzzy' " Fuzzy file finder

    " Usage: :Ag [pattern]
    " will search in current directory
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'navarasu/onedark.nvim'
    Plug 'sainnhe/sonokai'

    Plug 'onsails/lspkind.nvim'
    Plug 'neovim/nvim-lspconfig'
    " https://github.com/neovim/nvim-lspconfig
    " https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'

    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
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
set mouse=
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
" https://github.com/cloudhead/neovim-fuzzy/issues/50
let g:fuzzy_rootcmds = [ ["git", "rev-parse", "--show-toplevel"], ]
nnoremap <C-p> :FuzzyOpen <CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" previous/next tab
map <F9> :tabp <CR>
map <F10> :tabn <CR>

filetype plugin indent on
filetype plugin on

autocmd BufWritePre * :%s/\s\+$//e

syntax enable

if has('termguicolors')
  set termguicolors
endif

colorscheme sonokai
let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1

" colorscheme onedark
" let g:onedark_config = {
"     \ 'style': 'warmer',
" \}

" let g:airline_theme = 'molokai'
" let g:airline_powerline_fonts = 1
let g:airline_theme = 'sonokai'

lua <<EOF
    local lspconfig = require 'lspconfig'
    local cmp = require 'cmp'

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
        },
        {
            { name = 'buffer' },
        })
    })

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation
    end

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_flags = { debounce_text_changes = 150 }

    lspconfig['bashls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        filetypes = { 'sh', 'bash' },
        single_file_support = true
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
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("package.json")
    }

    lspconfig['denols'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    }

    lspconfig['rust_analyzer'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern 'Cargo.toml',
        -- Server-specific settings...
        settings = {
          ["rust-analyzer"] = {}
        }
    }

    -- Ref: https://github.com/redhat-developer/yaml-language-server
    lspconfig['yamlls'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
            yaml = {
                schemas = {
                    -- ["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible.json"] = "playbooks/*.yaml",
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {"ci/*.yml", ".gitlab-ci.yml"},
                    ["https://raw.githubusercontent.com/ansible/schemas/main/f/ansible.json"] = {"playbooks/*.yaml", "playbooks/*.yml"}
                    -- Ref: https://www.schemastore.org/json/
                    -- https://json.schemastore.org/eslintrc.json
                    -- https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json
                    -- https://json.schemastore.org/github-action.json
                    -- https://json.schemastore.org/tsconfig.json
                    -- https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json
                }
            }
        }
    }

    lspconfig['ansiblels'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { 'ansible-language-server', '--stdio' },
        filetypes = { 'yaml', 'yml' },
        root_dir = lspconfig.util.root_pattern 'ansible.cfg',
        single_file_support = false,
        settings = {
            ansible = {
                ansible = {
                    path = "ansible"
                },
                ansibleLint = {
                    enabled = true,
                    path = "/usr/bin/ansible-lint"
                },
                executionEnvironment = {
                    enabled = false
                },
                python = {
                    interpreterPath = "/usr/bin/python"
                }
            }
        }
    }

    lspconfig['marksman'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { 'marksman', 'server' },
        filetypes = { 'markdown' },
        root_dir = lspconfig.util.root_pattern '.marksman.toml',
        single_file_support = true
    }

    lspconfig['texlab'].setup {
        cmd = { 'texlab' },
        filetypes = { "tex", "plaintex", "bib" },
        root_dir = lspconfig.util.root_pattern '*.tex',
        single_file_support = false,
        capabilities = capabilities,
        settings = {
            texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              executable = "latexmk",
              forwardSearchAfter = false,
              onSave = false
            },
            chktex = {
              onEdit = false,
              onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
              args = {}
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = false
            }
          }
        }
    }
EOF
