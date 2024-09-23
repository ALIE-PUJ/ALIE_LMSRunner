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
RUN echo "/app/LM_Studio-0.3.2.AppImage --appimage-extract-and-run --no-sandbox &" > ~/.xinitrc
RUN echo "exec startxfce4 &" >> ~/.xinitrc
RUN echo 'sleep 20 && echo "y\n" | ~/.cache/lm-studio/bin/lms bootstrap &' >> ~/.xinitrc
RUN echo "tail -f /dev/null" >> ~/.xinitrc
RUN chmod +x ~/.xinitrc

# Carga el script de lanzamiento de VNC
COPY vnc-start.sh /app/vnc-start.sh
RUN chmod +x /app/vnc-start.sh

# Inicia el servidor VNC
ENTRYPOINT ["/app/vnc-start.sh"]
