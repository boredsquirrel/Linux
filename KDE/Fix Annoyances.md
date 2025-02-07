# Fix KDE Annoyances

### Baloo

```sh
balooctl disable &&\
balooctl purge &&\
echo "Baloo disabled!"
```bash

### Discover Notifier

[Docs about disabling autostart
files](<<https://docs.kde.org/stable5/en/plasma-workspace/kcontrol/autostart/inde>
x>
.html#disabling_autostart).

1. Enable autoupdates through a systemd service using your package manager and
Flatpak.
2. Override the notifier to prevent it from starting.

```sh
# Empty desktop entry
touch ~/.local/share/applications/org.kde.discover.notifier.desktop

# Empty override autostart entry
touch ~/.config/autostart/org.kde.discover.notifier.desktop

# If that was not enough, kill the process on startup.
cat > ~/.config/autostart/kill-plasma-notifier <<EOF
#!/bin/sh
# Wait a bit
sleep 10
killall -15 DiscoverNotifier && notify-send -a "Terminator" "Plasma Notifier
killed."
EOF
chmod +x ~/.config/autostart/kill-plasma-notifier
```bash

### KDE Connect

KDE Connect works over Wi-Fi and Bluetooth (since Plasma 6) and is very useful.
It may be a security risk though, and you can disable it manually.

Just prevent it from autostarting:

```sh
# Empty override autostart entry
touch ~/.config/autostart/org.kde.kdeconnect.daemon.desktop
```bash

Disable it entirely:

```sh
# Empty desktop entry
touch ~/.local/share/applications/org.kde.kdeconnect.daemon.desktop
```bash

### Geoclue

A background service used for geolocation based on IP.

It can be used with [beaconDB](https://beacondb.net) but you may not use it and
want to disable it.

With systemd:

```sh
sudo systemctl disable geoclue &&\
sudo systemctl mask geoclue
sudo systemctl disable --user geoclue &&\
sudo systemctl mask --user geoclue
```bash

### Power-Profiles-Daemon

You might want to switch to TuneD, it is great.

[See this post on how to switch to it on older Atomic
Desktops](<<https://discussion.fedoraproject.org/t/how-to-switch-to-tuned-on-fedo>
r>
a-40-atomic-desktops/134897).

The `tuned-ppd` package deals with desktop integration, so that your existing
sliders etc. will work. TuneD has way more options though.
