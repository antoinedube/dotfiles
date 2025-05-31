return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {
                    mason = false,
                    autostart = false,
                },
            },
            inlay_hints = { enabled = false },
        },
    },
}
