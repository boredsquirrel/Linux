#!/bin/bash

# setup automatic flatpak, rpm-ostree and distrobox upgrades
# firmware upgrades are currently disabled, due to requiring a reboot and being kinda unpredictable in that behavior.

# if already running
sudo systemctl disable --now auto-updates.service
sudo systemctl disable --now auto-updates.timer

########## SCRIPT ##############
sudo tee > /var/usrlocal/bin/autoupdates <<EOF
#!/usr/bin/sh

check_conditions() {
    local battery_ok=false
    local network_ok=false
    local ac_ok=false

    # BATTERY
    local battery_threshold=40
    local battery_message="Error: Battery charge below ${battery_threshold}%. Please plug in charger."
    local battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    if (( $battery_level >= $battery_threshold )); then
        battery_ok=true
    else
        echo "$battery_message" >&2
    fi

    # NETWORK
    local network_metered=$(nmcli -t -f GENERAL.METERED dev show | awk '{print $1}' | tail -n +2)
    local network_message="Error: Connected network is metered. Disconnect or switch to a different network."
    if [[ ! -z $network_metered && $network_metered == yes* ]]; then
        echo "$network_message" >&2
    else
        network_ok=true
    fi

#     # AC CONNECTED
#     # not used, uncomment and add snippet in main clause to use it
#     local ac_connected=$(cat /sys/class/power_supply/AC/online)
#     local ac_message="Not connected to AC power. Proceeding without it."
#     if (( $ac_connected != 1 )); then
#         echo "$ac_message" >&2
#     else
#         ac_ok=true
#     fi
}

  # UPDATES
run_commands() {
    flatpak update -y >&2 > /var/log/auto-updates.log
    flatpak uninstall --unused -y >&2 > /var/log/auto-updates.log
    rpm-ostree update >&2 > /var/log/auto-updates.log
    distrobox upgrade --all >&2 > /var/log/auto-updates.log
    #fwupdmgr upgrade >&2 > /var/log/auto-updates.log
}

  # MAIN CLAUSE
if $battery_ok && $network_ok; then
    run_commands
    # not disappearing notify-send message
    notify-send -t 0 -a "System" "System upgrade finished." "Check '/var/log/auto-updates.log' for changes."
fi
    # TODO: implement short change note with infos
    # NOTE: '&& $ac_ok' removed, not required
EOF

############ SERVICE ###############
sudo tee > /etc/systemd/system/auto-updates.service <<EOF
[Unit]
Description=Upgrade system when conditions are met
After=network-online.target

[Service]
Type=oneshot
ExecStart=/var/usrlocal/bin/autostart

StandardOutput=append:/var/log/auto-updates.log
StandardError=inherit
SyslogIdentifier=%N

# BACKGROUND
# To avoid high usage, noisiness etc. These may be too much
#Nice=15
IOSchedulingClass=idle

# REPEAT
# when conditions were not met, try again after 15 minutes
Restart=on-failure
RestartSec=900

[Install]
WantedBy=multi-user.target
EOF

############ TIMER ############

sudo tee > /etc/systemd/system/auto-updates.timer <<EOF && echo "timer placed"
[Unit]
Description=Run system updates every day

[Timer]
# run daily at 20:00
OnCalendar=*-*-* 20:00:00

# when start time missed, do immediately, but only 10min after boot
Persistent=true
OnBootSec=+10min
RandomizedDelaySec=5min

[Install]
WantedBy=timers.target
EOF

sudo systemctl enable --now auto-updates.timer && echo "timer enabled"

cat <<EOF

Use 'systemctl status auto-updates' to get the status.

Check '/var/log/auto-updates.log' the next days, for an alternative log.
EOF
