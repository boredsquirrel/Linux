a lot of custom commands you can add, to manage your device easier!

some commands are Fedora specific, like `qdbus-qt6` or `tuned`

### Regular stuff

standby 

```
systemctl suspend
```

lock

```
loginctl lock-session
```

reboot
```
reboot
# or
systemctl reboot
```

shutdown
```
init 0
# or
shutdown now
```

### Networking
get IP address and copy it, clipboard syncs to phone

requires: `wl-clipboard`

```
ip -4 addr show | awk '/inet / && $NF ~ /wlp/ {print $2}' | cut -d'/' -f1 | wl-copy  
```

## Display
### Scaling
scale HDMI1

```
# 1x
kscreen-doctor output.HDMI-1.scale.1

# 1,5x
kscreen-doctor output.HDMI-1.scale.1.5
```

### Light / Dark Mode

```
plasma-apply-colorscheme BreezeLight
plasma-apply-colorscheme BreezeDark
```

### Brightness

```
# +5
bctl 5
# -5
bctl -5
```

where `bctl` is a script containing

```
qdbus-qt6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.setBrightness "$(($(qdbus-qt6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.brightness) + $(($1 * 100))))"
```

otherwise you could also hardcode it and make it easier:

```
# +5
qdbus-qt6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.setBrightness "$(($(qdbus-qt6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.brightness) + 500))"

# -5
qdbus-qt6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.setBrightness "$(($(qdbus-qt6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.brightness) - 500))"
```
## System

### Bluetooth

GUI way, no password prompt

```
bluetoothctl show | grep -q 'Powered: yes' && echo -e 'power off\nquit' | bluetoothctl || echo -e 'power on\nquit' | bluetoothctl
```

systemd way, password prompt but more complete

```
if [[ $(systemctl is-active bluetooth) == "active" ]]; then run0 sh -c "systemctl disable --now bluetooth && systemctl mask bluetooth"; else run0 sh -c "systemctl unmask bluetooth && systemctl enable --now bluetooth"; fi
```

### Update
run a command/alias in a specific shell

```
fish -c 'update'
```

### Power profiles / tuneD
example for balanced
```
tuned-adm profile balanced && notify-send -a "TuneD" "⚖️ balanced mode on"
```

### Keyboard
switch layouts

```
qdbus-qt6 org.kde.keyboard /Layouts org.kde.KeyboardLayouts.switchToNextLayout
```

## Apps

### Firefox

run in bubblejail, with mullvad-vpn split-tunnelling, using a custom profile, opening a website

```
mullvad-exclude bubblejail run -- Firefox /usr/bin/firefox -p ÌNSECURE https://netflix.com/browse
```

### Dolphin
open dolphin in a directory, with a certain scaling

```
QT_SCALE_FACTOR=1.25 dolphin /var/home/user/BEREICHE/Freizeit/Torrents/
```
