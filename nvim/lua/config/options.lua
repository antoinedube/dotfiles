-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

vim.g.lazyvim_python_lsp = "ruff"
vim.g.lazyvim_python_ruff = "ruff"

opt.textwidth = 0
opt.formatoptions = "ro/qnl1jp" -- https://neovim.io/doc/user/change/#fo-table

opt.wrap = true
opt.spelllang = { "en", "fr" }
opt.swapfile = false

vim.g.autoread = true
