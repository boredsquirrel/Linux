# Custom Desktop Entries

Desktop entries are the graphical icons and names in your app menu and other areas. They follow [the Freedesktop specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html) and are used by all apps (except AppImages) and in other areas.

## System Actions

Some useful system actions can be "GUI-fied" using desktop entries. They will show up as apps.

If you want to run `sudo` actions, use `pkexec` instead, which shows a GUI password prompt.

### Bluetooth Toggle

If you want to disable Bluetooth permanently but keep the ability to enable it when needed, use the user variant. However, it requires these steps before:

```sh
# Copy system service to user dir
sudo cp /usr/lib/systemd/system/bluetooth.service /etc/systemd/user/bluetooth-user.service

# Disable and mask the system service
sudo systemctl disable --now bluetooth
sudo systemctl mask bluetooth

# Reload to make it work
systemctl --user daemon-reload
```

The user variant does not require `wheel` group permissions and does not display a password prompt.

### Execute or Install Files

Some files, like `.jar` archives or Android `.apk` packages, don't have a graphical "app" registered to execute them.

Most others, like system packages or `.flatpakref`, `.flatpakrepo`, normally have a graphical app store assigned to open them.

### Journalctl Errors

Sometimes you may need to get logs of your system. Systemd's `journalctl` is the standard tool for this.

That entry uses multiple actions for different log types.

![Screenshot of the journalctl error entry](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/journalctl-entry.jpg)

## Applications

System-wide installed applications have their `.desktop` entries in `/usr/share/applications/`. To edit them, copy them to `~/.local/share/applications/`. These will be preferred over the system entries, effectively overwriting them.

### Konsole

![Screenshot](https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/Desktop%20Entries/Images/konsole-desktop-entry.jpg)

Konsole has a few annoyances that can be easily fixed. It always opens in a new window, even though it supports tabs.

You may also want to add custom actions and profiles for certain tasks.

Adding a profile to launch inside a Distrobox:

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

You can do the same for:
- Running as root
- Running over SSH

Now place the desktop entry in the correct location, and it will change immediately.

### Firefox

![Screenshot](https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/Desktop%20Entries/Images/firefox-desktop-entry.jpg)

Firefox can use profiles too. You might want to run it in private browsing mode or exclude it from a VPN (e.g., MullvadVPN).

Use `firefox -p` or `flatpak run org.mozilla.firefox -p`, respectively. Create a new profile, use a custom location, and name the folder properly (instead of using the cryptic default name).

Run that profile in private browsing:

```sh
firefox -p --private-window
```

Exclude a custom insecure profile from VPN:

```sh
mullvad-exclude firefox -p INSECURE
```

Open a link in an excluded browser:

```sh
mullvad-exclude firefox -p INSECURE http://insecure.link.com
```

This is useful for logging into captive portals or using sites that block VPN servers.

Edit the Firefox desktop entry:

```sh
cp /usr/share/applications/org.mozilla.firefox.desktop ~/.local/share/applications/
```

### Delete App Data After Launching

This is Flatpak-specific and very useful. For example, the app [Decoder](https://flathub.org/apps/com.belmoussaoui.Decoder) keeps a history of all copied elements, which may not be desirable (e.g., for passwords).

Flatpaks store their `.desktop` entries in:

```
/var/lib/flatpak/app/APPNAME/current/active/export/share/applications/
```

Copy that to `~/.local/share/applications/` and edit it.

Flatpaks store app data in `~/.var/app/APPNAME/`, making deletion easy. Just add `&& rm -rf ~/.var/app/APPNAME` after the `Exec=` command, and it will delete itself after closing the app.

## Tips

If you want to find system icons or mimetypes (the name a file is recognized by), you can do both graphically in KDE.

### Finding System Icons

| Open the app menu | Find the icon name in the list |
|------------------|------------------------------|
| ![App launcher](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/applauncher-find-icons.jpg) | ![App icon list](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/find-icons.jpg) |

Change "programs" to "all" to display all icons. These names can be used directly in the `Icon=` line of a `.desktop` file.

### Finding Mimetypes

To associate an "app" with a specific file type (e.g., "adb install" or "java execute"), use the terminal:

```sh
cat /etc/mime.types | grep FILEEXTENSION

# Example:
cat /etc/mime.types | grep jar
```

Or use KDE's "File Association" settings and search for the file extension (e.g., "jar").

![System settings page for mimetypes](https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entries/Images/file-names.jpg)

Here, the mimetype is `application/x-java-archive`.

Example: See KDE Discover's associated mimetypes:

```sh
$ cat /usr/share/applications/org.kde.discover.desktop | grep Mime

MimeType=application/x-rpm;application/vnd.flatpak;application/vnd.flatpak.repo;application/vnd.flatpak.ref;