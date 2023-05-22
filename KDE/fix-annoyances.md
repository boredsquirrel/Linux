## Fix KDE Annoyances

## Baloo

```
balooctl disable &&\
balooctl purge &&\
echo "Baloo disabled!"
```

## Discover notifier

1. Enable autoupdates through anything using your package manager and Flatpak.

```
sudo mv /etc/xdg/autostart/org.kde.discover.notifier.desktop /etc/xdg/autostart/org.kde.discover.notifier.txt

# If that was not enough:
cat > ~/.config/autostart/kill-plasma-notifier <<EOF
#!/bin/sh
sleep 10
killall -15 DiscoverNotifier &&\
printf """$date:\n\nPlasmanotifier killed.""" > ~/.config/autostart/plasmanotifierlog ||\
printf """$date:\n\nPlasmanotifier not present""" > ~/.config/autostart/plasmanotifierlog
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
