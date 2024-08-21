## Automatic system updates, done right

Fedora Atomic Desktops are currently not completely usable, as they follow the same unelegant path as "traditional" distributions, where users need to consent in doing updates.

This means that you cannot install these Distributions on "your grandmas PC", because she will never click on that tray icon and simply forget it.

Instead of relying on the user to determine when an update is wanted, this should be done logically and automated.

This, in addition to removing the GUI software store integrations, also speeds up performance quite a lot. See below.

> [!NOTE]
> Also take a look at [ublue-update](https://github.com/ublue-os/ublue-update), a project doing something very similar, but in a more generalistic way, using [topgrade](https://github.com/topgrade-rs/topgrade).

### 1. A Service detecting if conditions are met

Conditions:
- Device must be charging (optional)
- Device must have over x% charge (default 40)
- Active network must not be "metered"

```
sudo tee > /etc/systemd/system/auto-updates.service <<EOF
[Unit]
Description=Upgrade system when conditions are met
After=network-online.target

[Service]
Type=oneshot

######## CONDITIONS ###########
# require a power connection (optional)
#ExecStartPre=sh -c '[ $(cat /sys/class/power_supply/AC/online) = 1 ]'

# require battery over 40%
ExecStartPre=sh -c '[ $(cat /sys/class/power_supply/BAT0/capacity) -ge 40 ]'

# require the connected network to NOT be "metered"
# this value is not assigned by default!
# Go to your network settings to set phone hotspots etc. as "metered"/"getaktet" to avoid high data usage
ExecStartPre=sh -c '! $(nmcli -t -f GENERAL.METERED dev show | grep -q 'yes')'

######## UPDATES ###########
# delete old logs
ExecStartPre=echo "Auto-Update Logs:" > /var/log/auto-updates.log

# timestamp
ExecStartPre=sh -c 'echo "Last system update: $(date)" > /var/log/auto-updates.log'

# Flatpak
ExecStart=/usr/bin/echo "Flatpak Updates:" >> /var/log/auto-updates.log
ExecStart=/usr/bin/flatpak update -y >> /var/log/auto-updates.log
ExecStart=/usr/bin/echo "Flatpak Cleanups:" >> /var/log/auto-updates.log
ExecStart=/usr/bin/flatpak uninstall --unused >> /var/log/auto-updates.log

# rpm-ostree
ExecStart=/usr/bin/echo "System:" >> /var/log/auto-updates.log
ExecStart=/usr/bin/rpm-ostree update >> /var/log/auto-updates.log

# Distrobox
ExecStart=/usr/bin/echo "Distrobox:" >> /var/log/auto-updates.log
ExecStart=/usr/bin/distrobox upgrade --all >> /var/log/auto-updates.log

# Firmware updates
# These require a restart and may be interruptive.
# A good system needs to be found
#ExecStart=/usr/bin/echo "Firmware:" >> /var/log/auto-updates.log
#ExecStart=/usr/bin/fwupdmgr upgrade >> /var/log/auto-updates.log

# redundant: write errors to log
#StandardError=file:/var/log/auto-updates.log

######## NOTIFICATION ##########
# GUI message displaying package changes, never disappearing
# TODO: implement short change note with infos
ExecStartPost=/usr/bin/notify-send -t 0 -a "System" "System upgrade finished." "Check '/var/log/auto-updates.log' for changes."

######## BACKGROUND #########
# To avoid high usage, noisiness etc. These may be too much
#Nice=15
IOSchedulingClass=idle

######### REPEAT #############
# when conditions were not met, try again after 15 minutes
Restart=on-failure
RestartSec=900

[Install]
WantedBy=multi-user.target
EOF



sudo tee > /etc/systemd/system/auto-updates.timer <<EOF && echo "timer placed"
[Unit]
Description=Run system updates every day

[Timer]
# run daily at 20:00
OnCalendar=*-*-* 20:00:00
# when not possible to start, repeat as soon as possible
Persistent=true

[Install]
WantedBy=timers.target
EOF
```

> [!WARNING]
> It is important to manually set metered networks as so, as Networkmanager has no way of differentiating phone hotspots, USB-tethering over a phone or other indirectly metered connections from regular Wifis.

*(This is way easier on Android/phones, where one can assume that cell data is limited and the device uses a different antenna for it, and Wifi is mostly unmetered.)*

### 2. A timer repeating that service daily

```
sudo tee > /etc/systemd/system/auto-updates.timer <<EOF && echo "timer placed"
[Unit]
Description=Run system updates every day

[Timer]
# run daily at 20:00
OnCalendar=*-*-* 20:00:00
# when not possible to start, repeat as soon as possible
Persistent=true

[Install]
WantedBy=timers.target
EOF
```

### 3. Change some parameters if needed
In the service:
- disable removing old logs for testing
- change `Nice=15` and `IOSchedulingClass=idle` if they prevent updates

In the timer:
- change interval

### 4. Start the service

```
sudo systemctl enable --now auto-updates.service
sudo systemctl enable --now auto-updates.timer
```

You may want to remove the redundant GUI store integration. It works well but is not needed.

```
# Silverblue / Workstation Atomic / GNOME Atomic
rpm-ostree override remove gnome-software-rpm-ostree

# Kinoite / KDE Atomic
rpm-ostree override remove plasma-discover-rpm-ostree plasma-discover-notifier
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