# Custom Desktop Entries

Desktop entries are the graphical icons+name in your app menu, and in other areas. They follow [the Freedesktop specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html) and are used by all apps (not Appimages lol) and in other areas.

## System Actions
Some useful system actions can be "gui-fied" using desktop entries. They will show up as apps.

If you want to run `sudo` actions, use `pkexec` instead, which shows a GUI password prompt.

### Bluetooth toggle
If you want to disable bluetooth for good, but keep the ability to enable it when wanted.

## Applications

Systemwide installed applications have their .desktop entry in `/usr/share/applications/`, to edit them, copy them to `~/.local/share/applications/`. These will be preferred over the system entries, practically overwriting them.

### Konsole
![screenshot](https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/Desktop%20Entries/Images/konsole-desktop-entry.jpg)

Konsole has a few annoyances that can be easily fixed. It always opens in a new Window, while it has support for tabs.

You may also want to add custom actions and profiles for certain tasks.

Adding a profile to launch inside a Distrobox:

```
mkdir -v ~/.local/share/konsole
cat > ~/.local/share/konsole/FedoraBox.profile <<EOF
[Appearance]
ColorScheme=BlueOnBlack

[General]
Command=distrobox-enter FedoraBox -- fish
Icon=Box
Name=Fedorabox
Parent=FALLBACK/
EOF
```

You can do the same for 
- running as root
- running over ssh

Now place my desktop entry in the correct location and it will change immediately.

### Firefox
![screenshot](https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/Desktop%20Entries/Images/firefox-desktop-entry.jpg)

Firefox can use Profiles too. Or you might want to run it in private browsing mode, or exclude it from a VPN (here MullvadVPN as example)

Use `firefox -p` or `flatpak run org.mozilla.firefox -p` respectively, create a new profile, use a custom location and use a Folder with a dedicated name. Otherwise it will be a cryptic sequence of symbols.

Run that profile but in private browsing:

```
firefox -p --private-window
```

Exclude a custom insecure profile from VPN
```
mullvad-exclude firefox -p INSECURE
```

Open a link in such an excluded browser:

```
mullvad-exclude firefox -p INSECURE http://insecure.link.com
```

This is needed for logging into captive portals (yes, they suck...) or using shitty websites that block VPN servers.

Edit the Firefox desktop entry like that:
```
cp /usr/share/applications/org.mozilla.firefox.desktop ~/.local/share/applications/
```

### Delete App data after launching
This is Flatpak specific and very useful. For example the app [Decoder](https://flathub.org/apps/com.belmoussaoui.Decoder) will keep a history of all copied elements, even though this may not be wanted (i.e. sending passwords)

Flatpaks have their desktop entries in `/var/lib/flatpak/app/APPNAME/current/active/export/share/applications/`, copy that to `~/.local/share/applications/` and edit it here.

Flatpaks store their appdata in `~/.var/app/APPNAME/` which makes deleting it really easy, just add `&& rm -rf ~/.var/app/APPNAME` after the `Exec=` command and it will delete it self after closing the app.

### Other applications
There are more appplications with custom actions:

Stream a media file with VLC:
```
vlc -vvv http://example.com/stream
```

Start a libreoffice program with a specified template:
```
libreoffice --writer --template "name"
```

Thunderbird, same profile feature as Firefox, offline mode
```
thunderbird --no-remote -P "profile"
thunderbird --offline
```

Audacity/Tenacity, record immediately
```
audacity --record
```

Start KDEnlive in a specific Workspace
```
kdenlive --workspace "MyWorkspace"
```

Open Telegram Desktop with specific account:
```
telegram-desktop --account "account_name"
```

Signal Desktop, different profile, start in tray
```
signal-desktop --profile="/path/to/profile"
signal-desktop --start-in-tray
```

Element Desktop
```
element-desktop --profile="/path/to/profile"
element-desktop --start-minimized
element-desktop --enable-tray-notifications
```

OBS Studio
```
obs --studio-mode
obs --startrecording
obs --startstreaming
obs --profile "profile_name"
```

KeepassXC
```
keepassxc --keyfile="/path/to/keyfile"
```

