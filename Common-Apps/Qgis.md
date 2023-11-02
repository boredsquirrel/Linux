# Install ![QGIS Icon](https://docs.qgis.org/3.34/en/_static/logo.png) QGIS on
<img src="https://fedoraproject.org/assets/images/logos/fedora-blue.png"
     width="250"
     height="70" />
     
Create a Distrobox on Base Fedora 39

```
distrobox-create Fedora39 -i registry.fedoraproject.org/fedora-toolbox:39
distrobox-enter Fedora39
```

Install needed QGIS & Dependencies
```
sudo dnf install -y qgis python3-qgis
```

Create a custom App launcher that forces X11 (avoid QGIS Warning, supposedly more features)
```
cat > ~/.local/share/applications/Fedora39-org.qgis.qgis.desktop <<EOF
[Desktop Entry]
Categories=Education;Science;Geography;
Exec=env QT_QPA_PLATFORM=xcb /usr/bin/distrobox-enter -n Fedora39 -- qgis %F
Icon=qgis
Keywords=map;globe;postgis;wms;wfs;ogc;osgeo;
MimeType=image/tiff;image/jpeg;image/jp2;application/vnd.google-earth.kmz;application/vnd.google-earth.kml+xml;
Name=QGIS Desktop  (on Fedora39)
StartupWMClass=QGIS3
Type=Application
X-Desktop-File-Install-Version=0.26
EOF
```
