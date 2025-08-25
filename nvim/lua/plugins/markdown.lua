return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            heading = {
                enabled = true,
                sign = true,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                width = "full",
                above = "▄",
                below = "▀",
                position = "inline",
            },
            render_modes = { "n" },
            bullet = { icons = { { "󰫶 ", "󱂉 " } }, left_pad = 2 },
        },
    },
}
