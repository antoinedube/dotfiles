import subprocess

from libqtile.config import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = "mod4"

keys = [
    Key([mod], "space", lazy.layout.next()),
    Key([mod], "Return", lazy.spawn("urxvt")),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "y", lazy.widget['notify'].toggle()),
    Key([mod, "shift"], "g", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_down()),
    Key([mod], "1", lazy.to_screen(1)),
    Key([mod], "2", lazy.to_screen(0))
]

groups = [Group(i) for i in "uiojklbnm"]

for i in groups:
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

for i in groups:
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.xmonad.MonadTall(
        ratio=0.5,
        border_focus='#333333',
        border_normal='#111111'
    ),
    layout.Max()
]

widget_defaults = dict(
    font='Terminus',
    fontsize=14,
    padding=2,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Spacer(),
            ],
            25,
            background=['#1F1F1F', "#2C2C2F"]
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.Spacer(),
                widget.Notify(),
                widget.Systray(padding=10),
                widget.Clock(format='%A %B %d, %Y -- %H:%M:%S'),
            ],
            25,
            background=['#1F1F1F', "#2C2C2F"]
        ),
    ),
]

subprocess.call(['hsetroot', '-fill', '/home/antoine/Pictures/Wallpaper/blackpattern.jpg'])

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
