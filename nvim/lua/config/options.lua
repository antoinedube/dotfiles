-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

vim.g.lazyvim_python_lsp = "ruff"
vim.g.lazyvim_python_ruff = "ruff"

opt.textwidth = 160
opt.wrap = true
opt.spelllang = { "en", "fr" }
opt.swapfile = false
