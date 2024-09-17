FROM ubuntu:22.04
RUN apt-get update && apt-get install -y firefox x11vnc xvfb
RUN apt-get update && apt-get install -y xfce4 xfce4-goodies
RUN echo "exec startxfce4" > ~/.xinitrc && chmod +x ~/.xinitrc
CMD ["x11vnc", "-create", "-noxrecord", "-noxfixes", "-noxdamage", "-forever", "-passwd", "trustno1"]
