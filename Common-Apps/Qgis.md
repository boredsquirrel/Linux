# Install ![QGIS Icon](https://docs.qgis.org/3.34/en/_static/logo.png) QGIS on
<img src="https://fedoraproject.org/assets/images/logos/fedora-blue.png"
     width="250"
     height="70" />
     
Create a minimal Fedora Distrobox (Container)

```
distrobox-create Fedora -i registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora) #or use the latest version manually
distrobox-enter Fedora
```

Install QGIS & needed Dependencies
```
sudo dnf install -y qgis python3-qgis
```

Create a custom App launcher that forces X11/XWayland (needed to prevent breakages on Wayland, until Qt6 port is done)
```
cat > ~/.local/share/applications/Distrobox-org.qgis.qgis.desktop <<EOF
[Desktop Entry]
Categories=Education;Science;Geography;
Exec=env QT_QPA_PLATFORM=xcb /usr/bin/distrobox-enter Fedora -- qgis %F
Icon=qgis
Keywords=map;globe;postgis;wms;wfs;ogc;osgeo;
MimeType=image/tiff;image/jpeg;image/jp2;application/vnd.google-earth.kmz;application/vnd.google-earth.kml+xml;
Name=QGIS Desktop (Distrobox)
StartupWMClass=QGIS3
Type=Application
EOF
```

Keep your apps updated!

```
distrobox upgrade --all
```
