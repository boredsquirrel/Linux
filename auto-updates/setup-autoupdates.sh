#!/bin/bash

# setup automatic flatpak, rpm-ostree and distrobox upgrades
# firmware upgrades are currently disabled, due to requiring a reboot and being kinda unpredictable in that behavior.

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



sudo systemctl enable --now auto-updates.service && echo "service enabled"
sudo systemctl enable --now auto-updates.timer && echo "timer enabled"

cat <<EOF

Use 'systemctl status auto-updates' to get the status.

Check '/var/log/auto-updates.log' the next days, for an alternative log.
EOF
