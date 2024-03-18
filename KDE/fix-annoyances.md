## Fix KDE Annoyances

## Baloo

```
balooctl disable &&\
balooctl purge &&\
echo "Baloo disabled!"
```

## Discover notifier

[Docs about disabling autostart files](https://docs.kde.org/stable5/en/plasma-workspace/kcontrol/autostart/index.html#disabling_autostart)

1. Enable autoupdates through a systemd service using your package manager and Flatpak
2. Override the notifier to prevent it from starting

```
# empty desktop entry
touch ~/.local/share/applications/org.kde.discover.notifier.desktop

# empty override autostart entry
touch ~/.config/autostart/org.kde.discover.notifier.desktop

# If that was not enough, kill the process on startup.
cat > ~/.config/autostart/kill-plasma-notifier <<EOF
#!/bin/sh
# wait a bit
sleep 10
killall -15 DiscoverNotifier && notify-send -a "Terminator" "Plasma Notifier killed."
EOF
chmod +x ~/.config/autostart/kill-plasma-notifier
```

## KDE Connect
KDE Connect works over Wifi and Bluetooth (since Plasma 6) and is very useful. It may be a security risk though, and you can disable it manually.

just prevent it from autostarting:
```
# empty override autostart entry
touch ~/.config/autostart/org.kde.kdeconnect.daemon.desktop
```

disable it entirely:
```
# empty desktop entry
touch ~/.local/share/applications/org.kde.kdeconnect.daemon.desktop
```

## Geoclue
A background service used for geolocation based on IP, likely not needed.

```
sudo systemctl disable geoclue &&\
sudo systemctl mask geoclue
```

## Power-profiles-daemon
If your Hardware works with [TLP](https://linrunner.de/tlp), use that instead. Fedora will switch to [tuned](https://github.com/redhat-performance/tuned) in the future, and [ublue](https://universal-blue.org) already uses it.

Consider
- disabling cores (brutal method)
- switching the governor (TLP, tuned)
- changing the CPU,GPU and bus clock ([Ryzenadj](https://github.com/FlyGoat/RyzenAdj), ...)

```
sudo systemctl disable power-profiles-daemon &&\
sudo systemctl mask power-profiles-daemon
```

enable TLP

```
PACKAGEMANAGER install tlp
systemctl enable --now tlp.service
```

If you get issues with USB devices not working anymore, disable "`USB_AUTOSUSPEND`":

```
sudo sed -i 's/USB_AUTOSUSPEND=1/USB_AUTOSUSPEND=0/g' /etc/tlp.conf
```

