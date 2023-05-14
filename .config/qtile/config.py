import os
import subprocess
from typing import List
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import json


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])


mod = "mod4"
terminal = "alacritty"
browser = "firefox"
color_scheme = "onedark"
scripts_path = ".scripts"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "space", lazy.group.next_window()),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),

    # Resize left, right, down, left
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink()
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow()
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        ),
    Key([mod], "n", lazy.layout.normalize()),

    # Toggle floating, fullscreen
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), lazy.window.center()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # Hide, show bar
    Key([mod], "t", lazy.hide_show_bar(position="all")),

    # Launch a specific application
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "b", lazy.spawn(browser)),
    Key([mod], "r", lazy.spawn("rofi -show drun")),
    Key([mod], "e", lazy.spawn("thunar")),
    Key([mod], "F12", lazy.spawn("betterlockscreen -l")),
    Key([mod, "shift"], "e", lazy.spawn("alacritty -e ranger")),

    # Launch custom scripts
    Key([mod, "shift"], "c", lazy.spawn(f"./{scripts_path}/chxkbmap")),
    Key([mod, "shift"], "p", lazy.spawn(f"./{scripts_path}/toggle-picom")),
    Key([mod, "shift"], "r", lazy.spawn(f"./{scripts_path}/toggle-redshift")),
    Key([mod, "shift"], "w", lazy.spawn(f"./{scripts_path}/wall-random")),

    # Screenshot
    Key([], "Print", lazy.spawn(
        "scrot %Y-%m-%d-%T-screenshot.png -e 'xclip -selection clipboard -t image/png -i $f; mv $f ~/Pictures/screenshots/' &>/dev/null")),
    Key([mod], "s", lazy.spawn(
        "scrot --select %Y-%m-%d-%T-cut.png -e 'xclip -selection clipboard -t image/png -i $f; mv $f ~/Pictures/cuts/' &>/dev/null")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),
    Key([mod], "q", lazy.window.kill()),

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    # Brightness
    # Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),

    # Restart, Shutdown
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown())
]

groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

# group_labels = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

group_layouts = ["monadtall", "max", "monadwide", "monadwide",
                 "max", "bsp", "matrix", "bsp", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    ])


def load_color_scheme():
    path = os.path.expanduser(f"~/.config/qtile/themes/{color_scheme}.json")
    colors = []
    theme = open(path)
    data = json.load(theme)
    for value in data.values():
        colors.append(value)
    theme.close()
    return colors


colors = load_color_scheme()


def init_layout_theme():
    return {"border_width": 1,
            "margin": 6,
            "border_focus": colors[6],
            "border_normal": colors[0]
            }


layout_theme = init_layout_theme()

layouts = [
    layout.Max(**layout_theme),
    layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Matrix(**layout_theme),
]


def init_widgets_defaults():
    return dict(
        font="JetBrainsMono Nerd Font Bold",
        fontsize=12,
        padding=3,
        background=colors[0]
    )


widget_defaults = init_widgets_defaults()

extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.GroupBox(
            fontsize=12,
            padding=12,
            margin_x=0,
            borderwidth=3,
            disable_drag=True,
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors[3],
            highlight_color=colors[1],
            active=colors[4],
            inactive=colors[1],
            this_current_screen_border=colors[6],
            block_highlight_text_color=colors[0],
            background=colors[0],
            foreground=colors[9]
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.WindowName(
            background=colors[0],
            foreground=colors[7]
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.Systray(
            background=colors[0]
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.TextBox(
            text=" ",
            background=colors[0],
            foreground=colors[3]
        ),
        widget.CPU(
            format='{freq_current}GHz {load_percent}%',
            background=colors[0],
            foreground=colors[3]
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.TextBox(
            text=" ",
            background=colors[0],
            foreground=colors[5]
        ),
        widget.Memory(
            background=colors[0],
            foreground=colors[5]
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.TextBox(
            text="󰒍 ",
            background=colors[0],
            foreground=colors[8]
        ),
        widget.Net(
            interface="enp4s0",
            background=colors[0],
            foreground=colors[8]
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.TextBox(
            text=" ",
            background=colors[0],
            foreground=colors[4]
        ),
        widget.CheckUpdates(
            background=colors[0],
            foreground=colors[4],
            colour_have_updates=colors[4],
            colour_no_updates=colors[4],
            custom_command="checkupdates",
            no_update_string='0',
            display_format="{updates}"
        ),
        widget.Sep(
            linewidth=0,
            padding=6
        ),
        widget.TextBox(
            text=" ",
            background=colors[0],
            foreground=colors[6]
        ),
        widget.Clock(
            background=colors[0],
            foreground=colors[6],
            # format="%Y-%m-%d %H:%M"
            format="%a, %b %d %H:%M"
        ),
        widget.CurrentLayoutIcon(
            foreground=colors[9],
            scale=0.6
        )
    ]
    return widgets_list


widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


widgets_screen1 = init_widgets_screen1()


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=24, opacity=1))]


screens = init_screens()


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='VirtualBox Machine'), # VirtualBox VMs
    Match(wm_class='Nm-connection-editor'), # Network Manager Connection Editor
    Match(wm_class='Galculator'),
    Match(wm_class='Browser'),
], **layout_theme)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
