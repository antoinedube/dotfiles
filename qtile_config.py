#!/usr/bin/env python

import os
import socket
import subprocess

from libqtile import layout, bar, widget
from libqtile.command import lazy
from libqtile.config import Key, Screen, Group

group_box_settings = dict(
    borderwidth=0,
    disable_drag=True,
    center_aligned=True,
    fontsize=12,
    highlight_method='block',
    rounded=False,
    padding=10,
    spacing=2
)

single_screen_with_battery = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**group_box_settings),
                widget.Prompt(),
                widget.Spacer(),
                widget.Notify(default_timeout=5),
                widget.Battery(charge_char='+', discharge_char='-'),
                widget.Systray(padding=10),
                widget.Clock(format='%A %B %d, %Y -- %H:%M:%S'),
            ],
            30,
            background=['#1F1F1F', "#2C2C2F"]
        )
    )
]

single_screen = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**group_box_settings),
                widget.Prompt(),
                widget.Spacer(),
                widget.Notify(default_timeout=5),
                widget.Systray(padding=10),
                widget.Clock(format='%A %B %d, %Y -- %H:%M:%S'),
            ],
            30,
            background=['#1F1F1F', "#2C2C2F"]
        )
    )
]

dual_screen = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**group_box_settings),
                widget.Spacer(),
                widget.Notify(default_timeout=5),
                widget.DebugInfo(),
                widget.CPUGraph(),
                widget.MemoryGraph(),
                widget.NetGraph()
            ],
            30,
            background=['#1F1F1F', "#2C2C2F"]
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**group_box_settings),
                widget.Prompt(),
                widget.Spacer(),
                widget.Notify(default_timeout=5),
                widget.Systray(padding=10),
                widget.Clock(format='%A %B %d, %Y -- %H:%M:%S'),
            ],
            30,
            background=['#1F1F1F', "#2C2C2F"]
        )
    )
]


class Home:
    wallpaper_filename = '/home/antoine/Pictures/Wallpaper/mathematics.jpg'
    screen_setup = dual_screen


class Laptop:
    wallpaper_filename = '/home/antoine/Pictures/Wallpaper/mathematics.jpg'
    screen_setup = single_screen_with_battery


mod = "mod4"
current_directory = os.path.dirname(os.path.realpath(__file__))

keys = [
    Key([mod], "space", lazy.layout.next()),
    Key([mod], "Return", lazy.spawn("urxvt -e bash -c 'tmux'")),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "y", lazy.widget['notify'].toggle()),
    Key([mod, "shift"], "g", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_down()),
    Key([mod], "1", lazy.to_screen(1)),
    Key([mod], "2", lazy.to_screen(0)),
    Key(["control", "mod1"], "l", lazy.spawn(current_directory + "/lock_screen.sh"))
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
        border_focus='#303030',
        border_normal='#252525'
    ),
    layout.Max()
]

widget_defaults = dict(
    font='Roboto Mono Light',
    fontsize=14,
    padding=4,
)

if socket.gethostname() == 'Emilie':  # Home computer
    screen_setup = Home.screen_setup
    wallpaper_filename = Home.wallpaper_filename
elif socket.gethostname() == 'antoine76':  # Laptop
    screen_setup = Laptop.screen_setup
    wallpaper_filename = Laptop.wallpaper_filename
else:
    pass

screens = screen_setup
image_url = wallpaper_filename
subprocess.Popen(['hsetroot', '-fill', image_url])
subprocess.Popen(['pasystray'])

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

wmname = "LG3D"
