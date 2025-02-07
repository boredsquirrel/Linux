# **Fixed Markdown:**

```markdown
# Some Useful Scripts

## [sysinfo (KDE debug 
info)](https://github.com/trytomakeyouprivate/KDE-sysinfo-CLI)

This replicates the KDE system info output from System Settings but  
from the terminal.

By adding an app name (`sysinfo kate`), you also get information about  
an installed app (many package managers, including Flatpak, are supported!).

It supports automatic copying on Wayland and X11.

### Example output:
```sh
Specified App: kate-libs-23.04.1-1.fc38.x86_64
kate-plugins-23.04.1-1.fc38.x86_64
kate-23.04.1-1.fc38.x86_64

--- Software ---
OS: Fedora Linux 38.20230523.0 (Kinoite)
KDE Plasma: 5.27.5
KDE Frameworks: 5.106.0
Qt: 5.15.9
Kernel: 6.2.15-300.fc38.x86_64
Compositor: Wayland

--- Hardware ---
CPU: AMD Ryzen 5 PRO 3500U w/ Radeon Vega Mobile Gfx
RAM: 13.5 GB
GPU: AMD Radeon Vega 8 Graphics
Video Memory: 2048MB
```bash

## [Energysaver](https://github.com/trytomakeyouprivate/battery-saving)

Two scripts that are part of a **UDEV rule + Systemd service + script** setup.

### Goal

1. Detect battery and AC state.
2. If energy-saving mode is useful, deactivate a set number of  
   random CPU cores.
3. On AC, activate all cores again.

This works on all systems where TLP doesn't work. "Random" means  
different cores get disabled each time to avoid unequal usage.

It's a brute-force solution compared to setting a battery-saving  
governor, but it's reliable.

## flatpak-permission-cleaner

Many Flatpak apps have full root access to your system for compatibility.

This script replaces those permissions with:

- Home access.
- Mounted drives.
- SMB shares.

## flatpak shortcut creator: flatalias

This simple script does the following:

1. Lists installed Flatpak apps.
2. Extracts app names and app IDs.
3. Converts the app name to lowercase, removing numbers and dashes.
4. Checks if the app ID is already aliased. If not:
5. Creates an alias in `bashrc`, `zshrc`, and `fish.conf`.

### Example

```sh
# Installed app:
QGIS-Desktop    org.qgis.qgis 3.30.1  stable  flathub system

# Alias:
alias qgisdesktop="flatpak run org.qgis.qgis"
```bash

## [copr](https://github.com/trytomakeyouprivate/COPR-command)

Add COPR repos on Fedora without using DNF.

Useful for Fedora Kinoite, Silverblue, Sericea, etc.

## Rsync Helper

Backup software on Linux can be a struggle. Many GUI tools are bloated,  
unreliable in the background, or waste resources.

Rsync is built into most Linux distros and supports offline backups perfectly.

This script helps you set up an automatic Rsync service with a specified  
backup location.

## [fwupd-GUI](https://github.com/trytomakeyouprivate/fwupd-GUI)

Firmware updates depend on a **stable battery state and AC connection**.

This script prompts you via a GUI to accept or postpone updates.

*(Currently unfinished.)*

## [Easy Bash Loop

Helper](<https://github.com/trytomakeyouprivate/easy-bash-loops>)

Interactively create **yes/no loops** for scripts.  
The user is asked a question, and you define actions for "yes" and "no."

Supports copying the result to the clipboard or saving it to a file.

## [Polkit Helper](https://github.com/trytomakeyouprivate/Polkit-helper)

Easily create **polkit rules** so that you don't need to enter a  
password to launch applications like Virt-Manager or mount LUKS drives.

⚠ **Use sparingly!**

*(Currently needs revision.)*

## [Flatpak Updater](https://github.com/trytomakeyouprivate/Flatpak-updater)

Keep Flatpak apps updated via a **systemd service**.

A simpler alternative to  
[this Python
script](https://gist.github.com/ssokolow/db565fd8a82d6002baada946adb81f68),  
working with aliases instead of runfiles.

## cd2

An improved **Linux file manager terminal experience**.

Combines:

- `cd` for directory navigation.
- `ls` for listing contents.
- A formatted display of the current location.

Custom shortcuts allow:

- Sorting files by size.
- Sorting files by newest first.
- Displaying advanced info.

*(Currently broken.)*

##

[apkverify](<<https://github.com/trytomakeyouprivate/Android-Tipps/tree/main/APK->
S>
igner)

Easily verify if an **Android app** is secure.

```sh
apkverify test.apk
```bash

## logout

Logging out from a graphical desktop through the terminal is needlessly complex.

This script **logs you out from a KDE Wayland session**.

## findmod

A combination of `whereis` and your editor of choice (e.g., Kate).

```sh
findmod sysinfo
```bash

Opens the corresponding file in your editor.

## [flatpurge (not

ready)](<https://github.com/trytomakeyouprivate/Flatpak-trash-remover>)

Find and remove leftover directories of deleted Flatpak apps.

⚠ **Interactive—nothing is deleted without user consent.**

## [Flatpak Binary

Linker](<<https://github.com/trytomakeyouprivate/Linux/blob/main/Scripts/Flatpak->
b>
inaries)

Searches for Flatpak apps and links binaries (like `ffmpeg`) to `~/.bin`  
for direct access.

## Keelock

A customizable command for unlocking a **KeePassXC wallet** using a  
password stored in **KWallet**.

Could be extended to **GNOME Keyring**.

## [Distrobox

Autosetup](<https://github.com/trytomakeyouprivate/Distrobox-autosetup>)

Setup scripts for common Linux environments.

Allows running Linux apps on any Linux distro supporting Podman.

## [Security Shutdown](https://github.com/trytomakeyouprivate/Security-shutdown)

Detects **power source removal** and shuts down the machine.

Useful for servers with a buffer battery.

## git-clone-all

Clone **all repositories** for a specified user or group.

## mic-set

Fix **overamplified microphones**.

This script runs in `~/.config/autostart/` and:

- Sets mic volume to **40%**.
- **Mutes** the mic by default.

Works on PulseAudio. Not tested on PipeWire.

## website-language-checker

Create lists of websites by **domain language**.

Originally used for KDE search engine `.desktop` files but can be extended.

## [Mullvad Reminder](https://github.com/trytomakeyouprivate/Mullvad-Reminder)

*(Currently not working.)*

Goal: Keep the **GUI app open in the system tray** when the VPN is
disconnected,  
so you remember to reconnect.

## [Systemd Hold

Active](<https://github.com/trytomakeyouprivate/systemd-hold-active>)

*(Experimental, currently not working.)*

Enables a **service**, launches an **app**, and disables the service when  
the app closes.

## [Matlab GUI System

Integration](<https://github.com/trytomakeyouprivate/Matlab-Linux-Install>)

- Fish, Bash, Zsh integration.
- Binary linking.
- App launcher creation.
- MIME type setting for `.m` files.

## remove

A simple tool for deleting `.exe`, `.bat`, and `.dmg` files from downloaded
archives.

## utf8

Sets **locale to UTF-8** to fix language-related bugs.

## mkexec

Never type `chmod +x FILENAME` again!
