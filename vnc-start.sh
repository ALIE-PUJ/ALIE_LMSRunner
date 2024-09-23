#!/bin/bash

export DISPLAY=:1

echo Starting X server...
Xvfb $DISPLAY -screen 0 1920x1080x24 &
echo Started X server!

echo Starting session...
xinit ~/.xinitrc -- $DISPLAY &
echo Started session!

echo Starting VNC server...
x11vnc -noxrecord -noxfixes -noxdamage -forever -passwd trustno1 -display $DISPLAY
