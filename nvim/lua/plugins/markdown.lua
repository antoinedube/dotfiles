return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            checkbox = {
                custom = {
                    important = {
                        raw = "[~]",
                        rendered = "󰓎 ",
                        highlight = "DiagnosticWarn",
                    },
                },
            },
            code = { style = "language", width = "block", left_pad = 2, right_pad = 4 },
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
            bullet = { icons = { "●", "○", "◆", "◇" }, left_pad = 2 },
            pipe_table = { min_width = 12 },
        },
    },
}
