## Fix KDE Annoyances

### Baloo

Disable Baloo (KDE's file indexer) and clear its cache:

```sh
balooctl disable &&\
balooctl purge &&\
echo "Baloo disabled!"
```

---

### Discover Notifier

[Docs about disabling autostart files](https://docs.kde.org/stable5/en/plasma-workspace/kcontrol/autostart/index.html#disabling_autostart)

1. Enable auto-updates through a systemd service using your package manager and Flatpak.
2. Override the notifier to prevent it from starting.

```sh
# Empty desktop entry to prevent execution
touch ~/.local/share/applications/org.kde.discover.notifier.desktop

# Empty override autostart entry
touch ~/.config/autostart/org.kde.discover.notifier.desktop

# If that was not enough, kill the process on startup.
cat > ~/.config/autostart/kill-plasma-notifier <<EOF
#!/bin/sh
# Wait a bit
sleep 10
killall -15 DiscoverNotifier && notify-send -a "Terminator" "Plasma Notifier killed."
EOF
chmod +x ~/.config/autostart/kill-plasma-notifier
```

---

### KDE Connect

KDE Connect works over Wi-Fi and Bluetooth (since Plasma 6) and is very useful. However, if you consider it a security risk, you can disable it manually.

To prevent it from autostarting:
```sh
# Empty override autostart entry
touch ~/.config/autostart/org.kde.kdeconnect.daemon.desktop
```

To disable it entirely:
```sh
# Empty desktop entry
touch ~/.local/share/applications/org.kde.kdeconnect.daemon.desktop
```

---

### Geoclue

A background service used for geolocation based on IP. It can integrate with [BeaconDB](https://beacondb.net), but if you don’t use it, you may want to disable it.

Disable using systemd:

```sh
sudo systemctl disable geoclue &&\
sudo systemctl mask geoclue

sudo systemctl disable --user geoclue &&\
sudo systemctl mask --user geoclue
```

---

### Power-Profiles-Daemon

You might want to switch to **tuneD**, which provides more advanced power management.

[See this post on how to switch to it on older Atomic Desktops](https://discussion.fedoraproject.org/t/how-to-switch-to-tuned-on-fedora-40-atomic-desktops/134897).

The `tuned-ppd` package ensures that desktop integrations (like sliders) continue to work properly. However, **tuneD** offers significantly more configuration options.