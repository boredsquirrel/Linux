## Fix KDE Annoyances

## Baloo

```
balooctl disable &&\
balooctl purge &&\
echo "Baloo disabled!"
```

## Discover notifier

[Docs about disabling autostart files](https://docs.kde.org/stable5/en/plasma-workspace/kcontrol/autostart/index.html#disabling_autostart)

1. Enable autoupdates through anything using your package manager and Flatpak.

```
# User autostart overrides System autostart
sudo cp /etc/xdg/autostart/org.kde.discover.notifier.desktop ~/.config/autostart/org.kde.discover.notifier.desktop
echo "Hidden=True" >> ~/.config/autostart/org.kde.discover.notifier.desktop

# If that was not enough, kill the process on startup.
cat > ~/.config/autostart/kill-plasma-notifier <<EOF
#!/bin/sh
sleep 10
killall -15 DiscoverNotifier &&\
date > ~/.config/autostart/plasmanotifierlog
printf """\n\nPlasmanotifier killed.""" >> ~/.config/autostart/plasmanotifierlog ||\
printf """\n\nPlasmanotifier not present""" >> ~/.config/autostart/plasmanotifierlog
EOF
chmod +x ~/.config/autostart/kill-plasma-notifier
```

## Geoclue

```
sudo systemctl disable geoclue &&\
sudo systemctl mask geoclue
```

## Power-profiles-daemon
If your Hardware works with TLP, use that instead.

Consider
- disabling cores (brutal method)
- switching the governor (TLP)
- changing the CPU,GPU and bus clock (Ryzenadj, ...)

```
sudo systemctl disable power-profiles-daemon &&\
sudo systemctl mask power-profiles-daemon
```
