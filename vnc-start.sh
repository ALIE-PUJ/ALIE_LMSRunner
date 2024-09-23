#!/bin/bash

export DISPLAY=:1

echo Starting X server...
Xvfb $DISPLAY -screen 0 1080x720x24 &
echo Started X server!

echo Starting session...
# xinit ~/.xinitrc -- $DISPLAY &
exec startxfce4 &
echo Started session!

echo Starting VNC server...
x11vnc -noxrecord -noxfixes -noxdamage -forever -passwd trustno1 -display $DISPLAY -auth /tmp/xvfb.auth
