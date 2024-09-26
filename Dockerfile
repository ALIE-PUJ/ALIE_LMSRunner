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

# Descarga el modelo de lenguaje
RUN wget https://huggingface.co/luisalejandrobf/ALIE_Model-Q4_K_M-GGUF/resolve/main/alie_model-q4_k_m.gguf

## Copia la configuración de LMS
COPY .cache /root/.cache
COPY .config /root/.config

# Carga el script de lanzamiento de VNC
COPY vnc-start.sh /app/vnc-start.sh
RUN chmod +x /app/vnc-start.sh

# RUN ./vnc-start.sh

# Inicia el servidor VNC
CMD ["/app/vnc-start.sh"]
