FROM ubuntu:22.04

# Configura el servidor VNC
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y firefox x11vnc xvfb
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 xfce4-goodies
RUN echo "exec startxfce4" > ~/.xinitrc && chmod +x ~/.xinitrc

# Inicia el servidor VNC
CMD ["x11vnc", "-create", "-noxrecord", "-noxfixes", "-noxdamage", "-forever", "-passwd", "trustno1"]
