import subprocess

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = "mod4"

keys = [
    Key([mod], "space", lazy.layout.next()),
    Key([mod], "Return", lazy.spawn("urxvt")),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod],"Tab", lazy.next_layout()),
]

groups = [Group(i) for i in "uiophjkl"]

for i in groups:
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.xmonad.MonadTall(
        ratio=0.55,
        border_focus='#555555',
        border_normal='#222222'
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
                widget.Prompt(),
                widget.Spacer(),
                widget.Systray(),
                widget.Clock(format='%A %B %d, %Y -- %H:%M:%S'),
            ],
            25,
            background=['#050505',"#202020"]
        ),
    ),
]

subprocess.call(['hsetroot','-fill','/home/antoine/Pictures/Wallpaper/blackpattern.jpg'])

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
