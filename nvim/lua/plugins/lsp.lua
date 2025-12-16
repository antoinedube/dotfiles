return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- copilot.lua only works with its own copilot lsp server
                copilot = { enabled = false },
            },
        },
    },
}
