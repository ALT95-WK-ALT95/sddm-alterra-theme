#SDDM Alterra Theme
> Version 0.1 — Work in progress. Tested on Arch Linux with Hyprland.

Tema de SDDM inspirado en la interfaz de la PDA de Subnautica y la estética de la Corporación Alterra.

* Secuencia de arranque animada (carga del PDA) con sonido.
* Pantalla de login con logo de Alterra girando en 3D sobre el fondo del PDA.

## Capturas de pantalla

![Preview](screenshots/preview.png)

## Requisitos

* SDDM con soporte Qt5 Multimedia (`qt5-multimedia`).
* GStreamer (`gst-libav`, `gst-plugins-good`, `gst-plugins-bad`, `gst-plugins-ugly`).
* PipeWire o PulseAudio (para el sonido de login).

## Instalación

1. Clona este repositorio:
```bash
   git clone https://github.com/tuusuario/sddm-alterra-theme
```
2. Copia la carpeta al directorio de temas:
```bash
   sudo cp -r sddm-alterra-theme /usr/share/sddm/themes/
```
3. Edita `/etc/sddm.conf`:
```ini
   [Theme]
   Current=sddm-alterra-theme
```
4. Reinicia SDDM:
```bash
   sudo systemctl restart sddm
```
 Personalización

Puedes reemplazar los archivos de vídeo y audio dentro de Assets/videos/ y Assets/ manteniendo los mismos nombres, o editar las rutas en Main.qml y Login.qml.

Aviso sobre derechos de autor

Los archivos de los vídeos (Assets/videos/alterra_bienvenida.mp4, etc.) son propiedad de Unknown Worlds Entertainment y se incluyen aquí únicamente como fan art, sin intención de lucro. Estos archivos no están cubiertos por la licencia MIT de este repositorio.

Si eres el titular de los derechos y deseas que los retire, por favor abre un issue y los eliminaré de inmediato.

El código QML, las configuraciones y la estructura del tema son originales y se distribuyen bajo la licencia MIT.
Créditos

    Sonidos y ambientación de Subnautica: Unknown Worlds Entertainment.

    Tema base SDDM: sddm-video-music-theme de KHZ-INTL (licencia MIT).

    Tema creado por _WK_.
