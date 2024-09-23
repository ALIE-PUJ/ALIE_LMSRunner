#!/bin/bash

export DISPLAY=:1

rm /tmp/.X1-lock -fv

echo Starting X server...
Xvfb $DISPLAY -screen 0 1080x720x24 &
echo Started X server!

echo Starting DE...
exec startxfce4 &
sleep 5

echo Starting LMStudio...
/app/LM_Studio-0.3.2.AppImage --appimage-extract-and-run --no-sandbox &
sleep 20

echo Bootstrapping LMStudio CLI...
echo "y\n" | ~/.cache/lm-studio/bin/lms bootstrap &

echo Starting VNC server...
x11vnc -noxrecord -noxfixes -noxdamage -forever -passwd trustno1 -display $DISPLAY -auth /tmp/xvfb.auth
