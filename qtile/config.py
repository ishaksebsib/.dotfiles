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
from libqtile.utils import guess_terminal
import os
import subprocess


mod = "mod1"
win = "mod4"
terminal = "kitty"

# BASIC VARIABLES 
fonts=["FontAwesome Bold","SourceCodePro-ExtraLight"]
colors = {
    "bg_normal": "#000000",   # Background color
    "fg_normal": "#FFFFFF",   # Foreground color
}



keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Run App
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill/close focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([win], "w", lazy.spawn('google-chrome-stable'),desc='launch google chrome'),
    Key([win], "c", lazy.spawn('code'), desc="launch vscode"),
    Key([win], "t", lazy.spawn('telegram-desktop'), desc="Open File Managere"),


    ## LAUNCHER 
    Key([mod], "r", lazy.spawn('rofi -show drun'), desc="Launch app Launcher"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([win], "e", lazy.spawn('nemo'), desc="Open File Managere"),
    Key([mod, "control"], "o", lazy.spawn('sh -c ~/.config/rofi/scripts/power'), desc="Open Power OFF Options"),
    # Key([mod], "i", lazy.spawn('bash ~/.config/qtile/scripts/wifimenu.sh'), desc="Open Wifi Menu"),
    # Launch Flameshot for screen shoot
    Key([], "Print", lazy.spawn("flameshot gui")),


    # CONTROAL BRIGHTNESS

     # Increase brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +4%")),

    # Decrease brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 1%-")),

    # CONTROAL AUDIO 

    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),#Increase volume


    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),#Decrease volume

    
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),# Toggle Mute
    
    
   # Key([win], "m", lazy.spawn("togglemon"), desc="toogle monitor ")),

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
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus_stack=["#4B427E", "#353446"], border_width=3 , border_focus = "#4C566A" ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font=fonts[0],
    fontsize=12,
    padding=3,
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
                    fontsize=24,
                    borderwidth=3,
                    highlight_method='block',
                    active='#CAA9E0',
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
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/5.png',
                ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/search.png',
                #     margin=2,
                #     background='#282738',
                #     mouse_callbacks={"Button1": search},
                # ),

                # widget.TextBox(
                #     fmt='Search',
                #     background='#282738',
                #     font="JetBrains Mono Bold",
                #     fontsize=13,
                #     foreground='#CAA9E0',
                #     mouse_callbacks={"Button1": search},
                # ),


                widget.Image(
                    filename='~/.config/qtile/Assets/4.png',
                ),


                # widget.WindowName(
                #     background = '#353446',
                #     format = "{name}",
                #     font='JetBrains Mono Bold',
                #     foreground='#CAA9E0',
                #     empty_group_string = 'Desktop',
                #     fontsize=13,

                # ),

                widget.TextBox(text=" ",background='#353446', width=bar.STRETCH), # Stracher to make it full screen


                # widget.Image(
                #     filename='~/.config/qtile/Assets/3.png',
                # ),


                widget.Systray(
                    background='#282738',
                    fontsize=2,
                ),


                # widget.TextBox(
                #     text=' ',
                #     background='#282738',
                # ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/6.png',
                #     background='#353446',
                # ),


                # widget.Image(
                # filename='~/.config/qtile/Assets/Drop1.png',
                # ),

                # widget.Net(
                # format=' {up}   {down} ',
                # background='#353446',
                # foreground='#CAA9E0',
                # font="JetBrains Mono Bold",
                # prefix='k',
                # ),

                # widget.Image(
                    # filename='~/.config/qtile/Assets/2.png',
                # ),

                # widget.Spacer(
                    # length=8,
                    # background='#353446',
                # ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/Misc/ram.png',
                #     background='#353446',
                # ),


                widget.Spacer(
                    length=-7,
                    background='#353446',
                ),


                # widget.Memory(
                #     background='#353446',
                #     format='{MemUsed: .0f}{mm}',
                #     foreground='#CAA9E0',
                #     font="JetBrains Mono Bold",
                #     fontsize=13,
                #     update_interval=5,
                # ),


                # widget.Image(
                # filename='~/.config/qtile/Assets/Drop2.png',
                # ),



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
                    font='JetBrains Mono Bold',
                    background='#353446',
                    foreground='#CAA9E0',
                    format='{percent:2.0%}',
                    fontsize=13,
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/2.png',
                ),


                widget.Spacer(
                    length=8,
                    background='#353446',
                ),


                # widget.Battery(format=' {percent:2.0%}',
                    # font="JetBrains Mono ExtraBold",
                    # fontsize=12,
                    # padding=10,
                    # background='#353446',
                # ),

                # widget.Memory(format='﬙{MemUsed: .0f}{mm}',
                    # font="JetBrains Mono Bold",
                    # fontsize=12,
                    # padding=10,
                    # background='#4B4D66',
                # ),

                widget.Volume(
                    font='JetBrainsMono Nerd Font',
                    theme_path='~/.config/qtile/Assets/Volume/',
                    emoji=True,
                    fontsize=13,
                    background='#353446',
                ),


                widget.Spacer(
                    length=-5,
                    background='#353446',
                    ),


                widget.Volume(
                    font='JetBrains Mono Bold',
                    background='#353446',
                    foreground='#CAA9E0',
                    fontsize=13,
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/5.png',
                    background='#353446',
                ),

                widget.Clock(
                    format='%b %d',
                    background='#282738',
                    foreground='#CAA9E0',
                    font="JetBrains Mono Bold",
                    fontsize=13,
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
                    font="JetBrains Mono Bold",
                    fontsize=13,
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
