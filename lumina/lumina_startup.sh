#!/bin/sh
if xrandr | grep 2560x1440@55 > /dev/null; then
    xrandr --output HDMI1 --mode 2560x1440@55
fi

