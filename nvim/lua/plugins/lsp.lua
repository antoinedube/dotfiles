return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            servers = {
                -- copilot.lua only works with its own copilot lsp server
                copilot = { enabled = false },
            },
        },
    },
}
