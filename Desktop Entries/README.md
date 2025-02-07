# Custom Desktop Entries

Desktop entries are the graphical icons + names in your app menu and other areas. They follow [the Freedesktop specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html) and are used by all apps (not AppImages, though) and in other areas.

## System Actions
Some useful system actions can be "GUI-fied" using desktop entries. They will show up as apps.

If you want to run `sudo` actions, use `pkexec` instead, which shows a GUI password prompt.

### Bluetooth Toggle
If you want to disable Bluetooth permanently but keep the ability to enable it when needed, use the user variant by performing these steps:

```sh
# Copy system service to user directory
sudo cp /usr/lib/systemd/system/bluetooth.service /etc/systemd/user/bluetooth-user.service

# Disable and mask the system service
sudo systemctl disable --now bluetooth
sudo systemctl mask bluetooth

# Reload to apply changes
systemctl --user daemon-reload
```

The user variant does not require `wheel` group permissions and does not display a password prompt.

### Execute or Install Files
Some files, like `.jar` archives or Android `.apk` packages, don't have a graphical "app" registered to execute them.

Most others, like system packages or `.flatpakref`, `.flatpakrepo`, normally have a graphical app store assigned to open them.

### Journalctl Errors
Sometimes, you may need to retrieve logs from your system. Systemd's `journalctl` is the standard way to do this.

This entry uses multiple actions for different log types.

![Screenshot of the journalctl error entry](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/journalctl-entry.jpg)

## Applications

System-wide installed applications have their `.desktop` entries in `/usr/share/applications/`. To edit them, copy them to `~/.local/share/applications/`, where they will override system entries.

### Konsole
![Screenshot](https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/Desktop%20Entries/Images/konsole-desktop-entry.jpg)

Konsole has a few annoyances that can be easily fixed. By default, it always opens in a new window, though it supports tabs.

You may also want to add custom actions and profiles for specific tasks.

#### Adding a Profile to Launch Inside a Distrobox

```sh
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

Similar profiles can be created for:
- Running as root
- Running over SSH

Now, place the modified desktop entry in the correct location, and it will take effect immediately.

### Firefox
![Screenshot](https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/Desktop%20Entries/Images/firefox-desktop-entry.jpg)

Firefox supports multiple profiles, private browsing mode, and VPN exclusions (e.g., MullvadVPN).

#### Running a Profile in Private Browsing Mode

```sh
firefox -p --private-window
```

#### Excluding a Custom Insecure Profile from VPN

```sh
mullvad-exclude firefox -p INSECURE
```

#### Opening a Link in an Excluded Profile

```sh
mullvad-exclude firefox -p INSECURE http://insecure.link.com
```

This is useful for logging into captive portals or accessing sites that block VPN servers.

#### Editing the Firefox Desktop Entry

```sh
cp /usr/share/applications/org.mozilla.firefox.desktop ~/.local/share/applications/
```

### Delete App Data After Launching
This is Flatpak-specific and very useful. For example, the app [Decoder](https://flathub.org/apps/com.belmoussaoui.Decoder) retains a history of copied elements, which might not be desired.

Flatpaks have their `.desktop` entries in `/var/lib/flatpak/app/APPNAME/current/active/export/share/applications/`. Copy the relevant entry to `~/.local/share/applications/` and edit it.

Flatpaks store their app data in `~/.var/app/APPNAME/`, making deletion simple. Just append `&& rm -rf ~/.var/app/APPNAME` after the `Exec=` command to remove the data upon closing the app.

### Other Applications

#### Streaming a Media File with VLC
```sh
vlc -vvv http://example.com/stream
```

#### Launching LibreOffice with a Specific Template
```sh
libreoffice --writer --template "name"
```

#### Thunderbird: Using Multiple Profiles and Offline Mode
```sh
thunderbird --no-remote -P "profile"
thunderbird --offline
```

#### Audacity/Tenacity: Start Recording Immediately
```sh
audacity --record
```

#### Starting KDEnlive in a Specific Workspace
```sh
kdenlive --workspace "MyWorkspace"
```

#### Opening Telegram Desktop with a Specific Account
```sh
telegram-desktop --account "account_name"
```

#### Signal Desktop: Different Profile and Start in Tray
```sh
signal-desktop --profile="/path/to/profile"
signal-desktop --start-in-tray
```

#### Element Desktop
```sh
element-desktop --profile="/path/to/profile"
element-desktop --start-minimized
element-desktop --enable-tray-notifications
```

#### OBS Studio
```sh
obs --studio-mode
obs --startrecording
obs --startstreaming
obs --profile "profile_name"
```

#### KeepassXC
```sh
keepassxc --keyfile="/path/to/keyfile"
```

## Tips
If you want to find system icons or mimetypes (the name a file is recognized by), you can do both graphically in KDE.

### Finding System Icons

| Open the app menu | Find the icon name in the list |
|---------|---------|
| ![App Launcher](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/applauncher-find-icons.jpg) | ![App Icon List](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/find-icons.jpg) |

Change "programs" to "all" to display all icons. These names can be used directly in the `Icon=` line of a desktop entry.

### Finding Mimetypes
To associate an "app" with a specific file type (e.g., `.jar` for Java applications), use:

```sh
cat /etc/mime.types | grep FILEEXTENSION

# Example:
cat /etc/mime.types | grep jar
```

Alternatively, use KDE's "File Associations" settings page to search for a file extension (e.g., "jar").

![System Settings Page for Mimetypes](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/file-names.jpg)

For example, the mimetype for `.jar` files is `application/x-java-archive`.

#### Example: KDE Discover's Associated Mimetypes
```sh
$ cat /usr/share/applications/org.kde.discover.desktop | grep Mime

MimeType=application/x-rpm;application/vnd.flatpak;application/vnd.flatpak.repo;application/vnd.flatpak.ref;
```

