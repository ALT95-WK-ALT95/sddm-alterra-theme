# SDDM Alterra Theme
> Version 0.1 — Work in progress. Tested on Arch Linux with Hyprland.

An SDDM theme inspired by the Subnautica PDA interface and the Alterra Corporation aesthetic.

* Animated boot sequence (PDA loading screen) with sound.
* Login screen with a 3D rotating Alterra logo over the PDA background.

## Screenshots

![Previews](previews/)

## Requirements

* SDDM with Qt5 Multimedia support (`qt5-multimedia`).
* `qt5-wayland` (needed for Wayland rendering, especially on Intel GPUs).
* GStreamer (`gst-libav`, `gst-plugins-base`, `gst-plugins-good`, `gst-plugins-bad`, `gst-plugins-ugly`).
* PipeWire or PulseAudio (for the login sound).

## Installation

1. Clone this repository:
```bash
   git clone https://github.com/ALT95-WK-ALT95/sddm-alterra-theme
```
2. Copy the folder to the themes directory:
```bash
   sudo cp -r sddm-alterra-theme /usr/share/sddm/themes/
```
3. Edit `/etc/sddm.conf`:
```ini
   [Theme]
   Current=sddm-alterra-theme
```
4. Restart SDDM:
```bash
   sudo systemctl restart sddm
```

## Troubleshooting

### Audio works but the screen stays black

The problem may be caused by:
GStreamer picking a broken video sink (common on NVIDIA + Wayland).

On NVIDIA drivers under Wayland, QtMultimedia often picks `glimagesink`, which relies on OpenGL and can fail silently. Force it to use `waylandsink`.

Edit `/etc/sddm.conf` and add under the `[General]` section (create it if it doesn't exist):

```ini
[General]
GreeterEnvironment=QT_GSTREAMER_VIDEO_SINK=waylandsink
```
Restart SDDM:

```bash
sudo systemctl restart sddm
 ```
 
 
 
## Customization

You can replace the video and audio files inside `Assets/videos/` and `Assets/` as long as you keep the same filenames, or edit the paths in `Main.qml` and `Login.qml`.

## Copyright notice

The video files (`Assets/videos/alterra_bienvenida.mp4`, etc.) are property of Unknown Worlds Entertainment and are included here solely as fan art, with no intention of profit. These files are **not covered** by the MIT license of this repository.

If you are the rights holder and want them removed, please open an issue and I will delete them immediately.

The QML code, configurations, and theme structure are original and distributed under the MIT license.

## Credits

* Subnautica sounds and atmosphere: Unknown Worlds Entertainment.
* Base SDDM theme: [sddm-video-music-theme](https://github.com/KHZ-INTL/sddm-video-music-theme) by KHZ-INTL (MIT license).
* Theme created by _WK_.
