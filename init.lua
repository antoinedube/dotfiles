local function clone_paq()
    local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
    local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
        vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
        return true
    end
end

local function bootstrap_paq(packages)
    local first_install = clone_paq()
    vim.cmd.packadd("paq-nvim")
    local paq = require("paq")

    -- If not already installed
    if first_install then
        vim.notify("Installing plugins... If prompted, hit Enter to continue.")
    end

    -- Read and install packages
    paq(packages)
    paq:sync()
end

-- Call helper function
bootstrap_paq {
    'savq/paq-nvim',
    'preservim/nerdtree',
    'cloudhead/neovim-fuzzy',
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'vim-airline/vim-airline',
    'sainnhe/sonokai',

    'onsails/lspkind.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
}

-- vim options
vim.opt.autoindent = true
vim.opt.backspace = "2"
vim.opt.backup = false
vim.opt.complete = { ".", "w", "b", "u", "t" }
vim.opt.completeopt = { "menuone", "noinsert" }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencodings = "utf-8"
vim.opt.formatoptions = "n2ljp"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.listchars = { trail = "~", tab = ">-" } -- eol character is disabled
vim.opt.list = true
vim.opt.linebreak = true
vim.opt.backup = false
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabpagemax = 50
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.textwidth = 0
vim.opt.timeoutlen = 50
vim.opt.wildignorecase = true
vim.opt.wildmenu = true
vim.opt.wrap = true
vim.opt.wrapmargin = 0

-- FuzzyFinder
vim.g.fuzzy_rootcmds = { "git", "rev-parse", "--show-toplevel" }
vim.keymap.set('n', '<C-p>', ':FuzzyOpen<CR>', { noremap = true })

-- NERDTree
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
vim.NERDTreeShowHidden = 1

-- Tab navigation
vim.keymap.set('n', '<F9>', ':tabp<CR>', { noremap = true })
vim.keymap.set('n', '<F10>', ':tabn<CR>', { noremap = true })

vim.cmd('filetype plugin indent on')
vim.cmd('filetype plugin on')

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    command = ':%s/\\s\\+$//e'
})

vim.cmd('syntax enable')

vim.g.sonokai_style = 'espresso' -- Available values: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
vim.g.sonokai_better_performance = 1
vim.g.airline_theme = 'sonokai'
vim.cmd('colorscheme sonokai')

-- lspconfig
local lspconfig = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
-- local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation
-- end

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_flags = { debounce_text_changes = 150 }

lspconfig['bashls'].setup{
    -- on_attach = on_attach,
    flags = lsp_flags,
    cmd = { 'bash-language-server' },
    args = { 'start' },
    capabilities = capabilities,
    filetypes = { 'sh', 'bash' },
    single_file_support = true
}

lspconfig['pyright'].setup{
    -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

-- Ref: https://github.com/joe-re/sql-language-server
lspconfig['sqlls'].setup{
    -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern '.sqllsrc.json'
}

lspconfig['tsserver'].setup{
    -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("package.json")
}

lspconfig['denols'].setup{
    -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
}

lspconfig['rust_analyzer'].setup{
    -- on_attach = on_attach,
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
    -- on_attach = on_attach,
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
    -- on_attach = on_attach,
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
    -- on_attach = on_attach,
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

lspconfig['lua_ls'].setup {
    filetypes = { "lua" },
    -- root_dir = lspconfig.util.root_pattern '*.tex',
    single_file_support = true,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            }
        }
    }
}
