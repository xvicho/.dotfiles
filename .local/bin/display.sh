#!/usr/bin/sh
monitor_order=$(bspc query -M --names | head -1)

function disconnect() {
	xrandr --output LVDS-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output VGA-1 --off --output HDMI-1 --off --output DP-1 --off
	bspc wm -r
	bspc monitor HDMI-1 -r
	bspc monitor LVDS-1 -d 1 2 3 4 5 6
	barlauncher
	barlauncher
}

function connect() {
	xrandr --output LVDS-1 --primary --mode 1366x768 --pos 0x1080 --rotate normal --output VGA-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off
	bspc wm -r
	bspc monitor LVDS-1 -d 1 2 3 4 5 6
	bspc monitor HDMI-1 -d 7 8 9
	if [ $monitor_order = "HDMI-1" ]; then
		bspc wm -O LVDS-1 HDMI-1
	else
		bspc wm -O LVDS-1 HDMI-1
	fi
	barlauncher
	barlauncher
}

xrandr | grep "HDMI-1 connected" &> /dev/null && connect || disconnect
