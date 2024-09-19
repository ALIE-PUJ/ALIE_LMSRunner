FROM ubuntu:22.04

# Instala el servidor VNC
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y firefox x11vnc xvfb
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 xfce4-goodies

# Aplicación
WORKDIR /app

## Instala utilidades de configuración
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget

## Descarga e instala LMStudio
RUN wget https://huggingface.co/ALIE-PUJ/ALIE_LargeFiles/resolve/main/lmstudio-releases/LM_Studio-0.3.2.AppImage
RUN chmod +x LM_Studio-0.3.2.AppImage
RUN echo "sleep 5 && /app/LM_Studio-0.3.2.AppImage --appimage-extract-and-run --no-sandbox &" > ~/.xinitrc && chmod +x ~/.xinitrc
RUN echo "exec startxfce4" >> ~/.xinitrc && chmod +x ~/.xinitrc

# Inicia el servidor VNC
CMD ["x11vnc", "-create", "-noxrecord", "-noxfixes", "-noxdamage", "-forever", "-passwd", "trustno1"]
