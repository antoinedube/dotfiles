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
                backgrounds = {
                    "RenderMarkdownH1Bg",
                    "RenderMarkdownH2Bg",
                    "RenderMarkdownH3Bg",
                    "RenderMarkdownH4Bg",
                    "RenderMarkdownH5Bg",
                    "RenderMarkdownH6Bg",
                },
                foregrounds = {
                    "RenderMarkdownH1",
                    "RenderMarkdownH2",
                    "RenderMarkdownH3",
                    "RenderMarkdownH4",
                    "RenderMarkdownH5",
                    "RenderMarkdownH6",
                },
            },
            render_modes = { "n" },
            bullet = { icons = { "●", "○", "◆", "◇" }, left_pad = 2 },
            pipe_table = { min_width = 12 },
        },
    },
}
