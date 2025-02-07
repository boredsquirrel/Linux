# Custom Desktop Entries

Desktop entries are the graphical icons and names in your app menu and other
areas. They follow [the Freedesktop
specification](<https://specifications.freedesktop.org/desktop-entry-spec/desktop>
-entry-spec-latest.html) and are used by all apps (not AppImages) and in other
areas.

## System Actions

Some useful system actions can be "GUI-fied" using desktop entries. They will
show up as apps.

If you want to run `sudo` actions, use `pkexec` instead, which shows a GUI
password prompt.

### Bluetooth Toggle

If you want to disable Bluetooth permanently but keep the ability to enable it
when needed, use the user variant. However, it requires these steps before:

```sh
# Copy system service to user dir
sudo cp /usr/lib/systemd/system/bluetooth.service 
/etc/systemd/user/bluetooth-user.service

# Disable and mask the system service
sudo systemctl disable --now bluetooth
sudo systemctl mask bluetooth

# Reload to make it work
systemctl --user daemon-reload
```

The user variant does not require `wheel` group permissions and does not
display a password prompt.

### Execute or Install Files

Some files, like `.jar` archives or Android `.apk` packages, don't have a
graphical "app" registered to execute them.

Most others, like system packages or `.flatpakref`, `.flatpakrepo`, normally
have a graphical app store assigned to open them.

### Journalctl Errors

Sometimes you may need to get some logs of your system. Systemd's `journalctl`
is pretty standardized as the way to retrieve them.

That entry uses multiple actions for the log types.

![Screenshot of the journalctl error
entry](<https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entr>
ies/Images/journalctl-entry.jpg)

## Applications

System-wide installed applications have their `.desktop` entry in
`/usr/share/applications/`. To edit them, copy them to
`~/.local/share/applications/`. These will be preferred over the system
entries, practically overwriting them.

### Konsole

![Screenshot](<https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/D>
esktop%20Entries/Images/konsole-desktop-entry.jpg)

Konsole has a few annoyances that can be easily fixed. It always opens in a new
window, even though it supports tabs.

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

Now place my desktop entry in the correct location, and it will change
immediately.

### Firefox

![Screenshot](<https://raw.githubusercontent.com/trytomakeyouprivate/Linux/main/D>
esktop%20Entries/Images/firefox-desktop-entry.jpg)

Firefox can use profiles too. You might want to run it in private browsing mode
or exclude it from a VPN (here, MullvadVPN as an example).

Use `firefox -p` or `flatpak run org.mozilla.firefox -p`, respectively. Create
a new profile, use a custom location, and use a folder with a dedicated name.
Otherwise, it will be a cryptic sequence of symbols.

Run that profile but in private browsing:

```sh
firefox -p --private-window
```

Exclude a custom insecure profile from VPN:

```sh
mullvad-exclude firefox -p INSECURE
```

Open a link in such an excluded browser:

```sh
mullvad-exclude firefox -p INSECURE http://insecure.link.com
```

This is needed for logging into captive portals (yes, they suck...) or using
sites that block VPN servers.

Edit the Firefox desktop entry like this:

```sh
cp /usr/share/applications/org.mozilla.firefox.desktop 
~/.local/share/applications/
```

### Delete App Data After Launching

This is Flatpak-specific and very useful. For example, the app
[Decoder](https://flathub.org/apps/com.belmoussaoui.Decoder) will keep a
history of all copied elements, even though this may not be desired (i.e.,
sending passwords).

Flatpaks have their desktop entries in
`/var/lib/flatpak/app/APPNAME/current/active/export/share/applications/`. Copy
that to `~/.local/share/applications/` and edit it here.

Flatpaks store their app data in `~/.var/app/APPNAME/`, which makes deleting it
easy. Just add `&& rm -rf ~/.var/app/APPNAME` after the `Exec=` command, and it
will delete itself after closing the app.

## Tips

If you want to find system icons or mimetypes (the name a file is recognized
by), you can do both graphically in KDE.

### Finding System Icons

| Open the app menu | Find the icon name in the list |
|------------------|------------------------------|
| ![App
launcher](<https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20E>
ntries/Images/applauncher-find-icons.jpg) | ![App icon
list](<https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20Entri>
es/Images/find-icons.jpg) |

Change "programs" to "all" to display all icons. These names can directly be
used in the `Icon=` line.

### Finding Mimetypes

To associate an "app" with a specific file type (see "adb install" and "java
execute"), in the terminal, you can use:

```sh
cat /etc/mime.types | grep FILEEXTENSION

# Example:
cat /etc/mime.types | grep jar
```

Or you can use KDE's "File Association" settings page and search for the file
extension (here, "jar").

![System settings page for
mimetypes](<https://raw.githubusercontent.com/boredsquirrel/Linux/main/Desktop%20>
Entries/Images/file-names.jpg)

Here, the mimetype is `application/x-java-archive`.

As an example, see KDE Discover's associated mimetypes:

```sh
$ cat /usr/share/applications/org.kde.discover.desktop | grep Mime

MimeType=application/x-rpm;application/vnd.flatpak;application/vnd.flatpak.repo;
application/vnd.flatpak.ref;
```
