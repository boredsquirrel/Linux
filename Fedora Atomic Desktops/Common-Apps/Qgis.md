# Install ![QGIS Icon](https://docs.qgis.org/3.34/en/_static/logo.png) QGIS on
<img src="https://fedoraproject.org/assets/images/logos/fedora-blue.png"
     width="250"
     height="70" />

Use the upstream instructions instead.

- [Flatpak](https://qgis.org/resources/installation-guide/#flatpak)
(recommended, you can install plugins with a trick!)
- [Fedora and Atomic
Desktops](https://qgis.org/resources/installation-guide/#fedora)
- [Distrobox and
Toolbx](https://qgis.org/resources/installation-guide/#distrobox--toolbx)

## Trick: Run the App with XWayland

Create a custom App launcher that forces X11/XWayland

(needed to prevent breakages on Wayland, until Qt6 port is done)

```bash
cat > ~/.local/share/applications/Distrobox-org.qgis.qgis.desktop <<EOF
[Desktop Entry]
Categories=Education;Science;Geography;
Exec=env QT_QPA_PLATFORM=xcb /usr/bin/distrobox-enter Fedora -- qgis %F
Icon=qgis
Keywords=map;globe;postgis;wms;wfs;ogc;osgeo;
MimeType=image/tiff;image/jpeg;image/jp2;application/vnd.google-earth.kmz;applic

ation/vnd.google-earth.kml+xml;
Name=QGIS Desktop (Distrobox)
StartupWMClass=QGIS3
Type=Application
EOF
```bash
