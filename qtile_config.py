import os
import subprocess

from libqtile import layout, bar, widget
from libqtile.command import lazy
from libqtile.config import Key, Screen, Group

mod = "mod4"

current_directory = os.path.dirname(os.path.realpath(__file__))

keys = [
    Key([mod], "space", lazy.layout.next()),
    Key([mod], "Return", lazy.spawn("urxvt")),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "y", lazy.widget['notify'].toggle()),
    Key([mod, "shift"], "g", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_down()),
    Key([mod], "1", lazy.to_screen(1)),
    Key([mod], "2", lazy.to_screen(0)),
    Key(["control", "mod1"], "l", lazy.spawn(current_directory + "/lock_screen.sh")),
    Key(["control", "mod1", "shift"], "g", lazy.spawn(current_directory + "/remote-genevieve.sh")),
    Key(["control", "mod1", "shift"], "c", lazy.spawn(current_directory + "/remote-chronosvm.sh")),
    Key(["control", "mod1", "shift"], "o", lazy.spawn(current_directory + "/remote-outils-internes.sh"))
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

group_box_settings = dict(
    borderwidth=2,
    disable_drag=True,
    center_aligned=True,
    fontsize=12
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**group_box_settings),
                widget.Prompt(),
                widget.Spacer(),
                widget.Notify(default_timeout=5),
                widget.Battery(),
                widget.Systray(padding=10),
                widget.Clock(format='%A %B %d, %Y -- %H:%M:%S'),
            ],
            30,
            background=['#1F1F1F', "#2C2C2F"]
        )
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**group_box_settings),
                widget.Spacer(),
                widget.DebugInfo(),
                widget.CPUGraph(),
                widget.MemoryGraph(),
                widget.NetGraph()
            ],
            30,
            background=['#1F1F1F', "#2C2C2F"]
        ),
    ),
]

image_url = '/home/antoine/wallpapers/' \
            + 'System76-Fractal_Mountains-by_Kate_Hazen_of_System76.png'
subprocess.Popen(['hsetroot', '-fill', image_url])

# subprocess.Popen(['pasystray'])

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

wmname = "LG3D"
