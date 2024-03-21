## Automatic rpm-ostree updates, done right

Fedora Atomic Desktops are currently not completely usable, as they follow the same unelegant path as "traditional" distributions, where users need to consent in doing updates.

This means that you cannot install these Distributions as they are on "your grandmas PC", because she will never click on that tray icon and simply forget it.

Instead of relying on the user to determine when an update is wanted, this should be done logically and automated.

### 1. A Service detecting if conditions are met

Conditions:
- Device must be charging (optional)
- Device must have over x% charge (default 40)
- Active network must not be "metered"

```
sudo cat > /etc/systemd/system/rpm-ostree-update.service <<EOF
[Unit]
Description=Upgrade system when conditions are met
After=network-online.target

[Service]
Type=oneshot
# require a power connection (optional)
# ExecStartPre=sh -c '[ $(cat /sys/class/power_supply/AC/online) = 1 ]'

# require battery over 40%
ExecStartPre=sh -c '[ $(cat /sys/class/power_supply/BAT0/capacity) -ge 40 ]'

# require the connected network to NOT be "metered"
# this value is not assigned by default! Go to your network settings,
# to set phone hotspots etc. as "metered" and avoid high data usage
ExecStartPre=sh -c '! $(nmcli -t -f GENERAL.METERED dev show | grep -q 'yes')'

ExecStart=/usr/bin/rpm-ostree update

# delete old logs
ExecStartPost=rm -f /var/log/rpm-ostree-automatic.log
# log the updates
ExecStartPost=sh -c 'echo "Last system update: $(date)" > /var/log/rpm-ostree-automatic.log'
StandardOutput=file:/var/log/rpm-ostree-automatic.log
StandardError=file:/var/log/rpm-ostree-automatic.log
# GUI message
ExecStartPost=/usr/bin/notify-send -a "System" "Updates finished." "Your System has been updated.\nReboot to apply them."
# run with low priority, when idling
Nice=15
IOSchedulingClass=idle

# when conditions were not met, try again after 15 minutes
Restart=on-failure
RestartSec=900

[Install]
WantedBy=multi-user.target
EOF
```

It is important to manually set metered networks as so, as Networkmanager has no way of differentiating phone hotspots, USB-tethering over a phone or other indirectly metered connections from regular Wifis.

(This is way easier on Android, where one can assume that cell data is limited and the device uses a different antenna for it, and Wifi is mostly unmetered.)

### 2. A timer repeating that service daily

```
sudo cat > /etc/systemd/system/rpm-ostree-update.timer <<EOF
[Unit]
Description=Run rpm-ostree updates every day

[Timer]
# run daily at 20:00
OnCalendar=*-*-* 20:00:00
# when not possible to start, repeat as soon as possible
Persistent=true

[Install]
WantedBy=timers.target
EOF
```

Start the service

```
sudo systemctl enable --now rpm-ostree-update.service
sudo systemctl enable --now rpm-ostree-update.timer
```

### Note
Fedora wants to implement automatic updates in future releases, as does ublue by default. If this service is not upstreamed, disable those services to avoid high data usage or other unwanted behaviors.

### ToDo
- [ ] custom non-daily interval
- [ ] interactive message using zenity or kdialog
- [ ] list updated apps in message
- [ ] warn on security critical updates

Similar todos:
- [ ] notify when a system upgrade is there (possible to suspend or ignore)
- [ ] notify when version is EOL without the possibility to ignore (but not enforcing)
- [ ] notify on firmware updates
- [ ] automatic flatpak updates (could just be added here)
- [ ] automatic `distrobox upgrade --all` (could just be added here)
- [ ] add a reboot button to the message (especially on security critical updates)
