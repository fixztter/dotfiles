#!/bin/sh

run()
{
    [ -z $(pgrep -x $1) ] && $@&
}

run "volumeicon"

run "nm-applet"

run "unclutter"

run "picom"

run "dunst"

run "nitrogen --restore"

run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

