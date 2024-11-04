# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook,  qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import os
import subprocess


mod = "mod1"
win = "mod4"
terminal = "alacritty"

# BASIC VARIABLES 
fonts={"normal": "JetBrainsMono Nerd Font Bold","nerd":"Fira Code Nerd Font Bold", "bold":"JetBrains Mono Bold"}
fonts_size={"small": 12,"normal":14, "larg":16}
colors = {
    "bg_normal": "#000000",   # Background color
    "fg_normal": "#FFFFFF",   # Foreground color
}

def move_app_to_next_screen():
    @lazy.function
    def _inner(qtile):
        screen = qtile.current_screen.index
        next_screen = (screen + 1) % len(qtile.screens)
        qtile.current_window.toscreen(next_screen)
        qtile.focus_screen(next_screen)
    return _inner


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Switch between screens
    Key([mod], "0", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([mod], "o", move_app_to_next_screen(), desc="Move current window to next monitor"),

    # Toggle between fullscreen and windowed mode
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "shift"], "f", lazy.hide_show_bar(), desc="Toggle show and hide toolbar/taskbar"), 


    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),


    # Move windows between left/right columns or move up/down in current stack.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),


    # Grow windows.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),


    ## LAUNCHER 
    Key([mod], "r", lazy.spawn('rofi -show drun'), desc="Launch app Launcher"),


    # Open/Close Applications
    Key([mod], "w", lazy.window.kill(), desc="Kill/close focused window"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([win], "e", lazy.spawn('thunar'), desc="Launch File Manager"),
    Key([win], "w", lazy.spawn('google-chrome-stable'),desc='launch google chrome'),
    Key([win], "n", lazy.spawn('obsidian'),desc='launch obsidian (note taking app)'),
    Key([win], "t", lazy.spawn('telegram-desktop'), desc="Launch Telegram"),
    Key([], "Print", lazy.spawn("rofi-screenshot"), desc="Launch Screenshot"),
    Key([win], "c", lazy.spawn('code'), desc="Launch Visual Studio Code"),
    Key(["control", "shift"], "Escape", lazy.spawn('WSysMon'), desc="Open task manager"),


    # Open Power Off - Shutdown - Restart Options
    Key([win], "l", lazy.spawn('i3lock -c 000000'), desc="Lock The Screen"),
    Key([mod, "control"], "o", lazy.spawn('sh -c ~/.config/rofi/scripts/power'), desc="Open Power OFF Options"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),


    ## CONTROLERS
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +4%"), desc="Increase brightness" ),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 1%-"), desc="Decrease brightness"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle"), desc="Toggle Mute"), 
    

    # Toggle
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
]

# █▀▀ █▀█ █▀█ █░█ █▀█ █▀
# █▄█ █▀▄ █▄█ █▄█ █▀▀ ▄█


group_labels = ["","","","","","","󰏃"]

groups = [Group(f"{i+1}", label=group_labels[i]) for i in range(7)]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(border_focus_stack=["#4B427E", "#353446"], border_width=3 , border_focus = "#4C566A" ),
    layout.Max(),
]

widget_defaults = dict(
    font=fonts["bold"],
    fontsize=fonts_size["normal"],
    padding=4,
)
extension_defaults = widget_defaults.copy()


def search():
    qtile.cmd_spawn("rofi -show drun")

def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")

screens = [

    Screen(
        top=bar.Bar(
            [
				widget.Spacer(length=15,
                    background='#282738',
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/launch_Icon.png',
                    margin=2,
                    background='#282738',
                    mouse_callbacks={"Button1":power},
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/6.png',
                ),


                widget.GroupBox(
                    font=fonts["bold"],
                    fontsize=fonts_size["small"],
                    borderwidth=8,
                    highlight_method='block',
                    active='#5699AF',
                    #active='#6272A4',
                    block_highlight_text_color="#91B1F0",
                    highlight_color='#4B427E',
                    inactive='#CAA9E0',
                    foreground='#4B427E',
                    background='#353446',
                    this_current_screen_border='#353446',
                    this_screen_border='#353446',
                    other_current_screen_border='#353446',
                    other_screen_border='#353446',
                    urgent_border='#353446',
                    rounded=True,
                    disable_drag=True,
                 ),


                widget.Spacer(
                    length=8,
                    background='#353446',
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/1.png',
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/layout.png',
                    background="#353446"
                ),


                widget.CurrentLayout(
                    background='#353446',
                    foreground='#CAA9E0',
                    fmt='{}',
                    font=fonts["normal"],
                    fontsize=fonts_size["normal"],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/5.png',
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/4.png',
                ),


                widget.TextBox(text=" ",background='#353446', width=bar.STRETCH), # Stracher to make it full screen


                widget.Systray(
                    background='#282738',
                    fontsize=2,
                ),



                widget.Spacer(
                    length=-7,
                    background='#353446',
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/2.png',
                ),


                widget.Spacer(
                    length=8,
                    background='#353446',
                ),


                widget.BatteryIcon(
                    theme_path='~/.config/qtile/Assets/Battery/',
                    background='#353446',
                    scale=1,
                ),


                widget.Battery(
                    background='#353446',
                    foreground='#CAA9E0',
                    format='{percent:2.0%}',
                    font=fonts["normal"],
                    fontsize=fonts_size["small"],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/2.png',
                ),


                widget.Spacer(
                    length=8,
                    background='#353446',
                ),

                widget.Volume(
                    theme_path='~/.config/qtile/Assets/Volume/',
                    emoji=True,
                    background='#353446',
                    fontsize=fonts_size["small"],
                ),


                widget.Spacer(
                    length=-5,
                    background='#353446',
                    ),


                widget.Volume(
                    background='#353446',
                    foreground='#CAA9E0',
                    font=fonts["normal"],
                    fontsize=fonts_size["small"],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/5.png',
                    background='#353446',
                ),

                widget.Clock(
                    format='%b %d',
                    background='#282738',
                    foreground='#CAA9E0',
                    font=fonts["normal"],
                    fontsize=fonts_size["small"],
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/Misc/clock.png',
                    background='#282738',
                    margin_y=6,
                    margin_x=6,
                ),


                widget.Clock(
                    format='%I:%M %p',
                    background='#282738',
                    foreground='#CAA9E0',
                    font=fonts["normal"],
                    fontsize=fonts_size["small"],
                ),


                widget.Spacer(
                    length=18,
                    background='#282738',
                ),

            ],
            24,
            border_color = '#ffffff',
            border_width = [0,0,0,0],
            margin = [1,0,1,1],

        ),
    ),
]


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


# AUTO Start Commnd this will only run on startapp

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
