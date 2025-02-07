#!/bin/bash

## Some useful Scripts

### [sysinfo (KDE debug info)](https://github.com/trytomakeyouprivate/KDE-sysinfo-CLI)

This replicates the KDE system info output from System-Settings, but from the terminal.

By just adding an appname (`sysinfo kate`) you also get information about an installed app (many package managers including Flatpak supported!)

It supports automatic copying on Wayland and X11.

Example output:
```

Specified App: kate-libs-23.04.1-1.fc38.x86_64
kate-plugins-23.04.1-1.fc38.x86_64
kate-23.04.1-1.fc38.x86_64

--- Software ---
OS: Fedora Linux 38.20230523.0 (Kinoite)
KDE Plasma: 5.27.5
KDE Frameworks: 5.106.0
Qt: 5.15.9
Kernel: 6.2.15-300.fc38.x86_64
Compositor: wayland

--- Hardware ---
CPU: AMD Ryzen 5 PRO 3500U w/ Radeon Vega Mobile Gfx
RAM: 13.5 GB
GPU: AMD Radeon Vega 8 Graphics
Video memory: 2048MB

```

### [Energysaver](https://github.com/trytomakeyouprivate/battery-saving)
Two scripts that are part of a UDEV-rule + Systemd-service + Script complex

Goal is:

1. Detect Battery and AC state
2. If Energysaving mode is useful, deactivate a set number of random CPU cores
3. On AC activate all cores again

This works on all systems where TLP doesnt work. Random means always different cores get disabled, to not get unequal usage or something.

Its a brutal solution over things like setting to a batterysave governor, but its reliable.

### flatpak-permission-cleaner
Many Flatpak apps have whole root access over your system for compatibility.

Replace these permissions with 

- home
- mounted drives
- smb shares
- ...

### flatpak shortcut creator flatalias
This really simple script does this:

1. List your installed Flatpak apps
2. Extract appname and appID
3. convert the appname to lowercase, remove numbers and dashes
4. check if the appID is already aliased and if not:
5. alias the cleaned appname to run the Flatpak in your bashrc, zshrc and fish.conf

Example:

```
# installed app:
QGIS-Desktop    org.qgis.qgis 3.30.1  stable  flathub system

# alias
alias qgisdesktop="flatpak run QGIS-Desktop"
```

### [copr](https://github.com/trytomakeyouprivate/COPR-command)
Add COPR repos on Fedora without using DNF.

Useful if you are on Fedora Kinoite/Silverblue/Sericea/...

### Rsync helper

Backup software on Linux is kind of a struggle. Many nice GUI tools available, but they are often bloated, dont run in the background reliably or waste resources.

Rsync is already integrated in most Linux distros and supports offline backups perfectly.

This script helps you to setup your own Rsync service, running automatically, with specified Location and so on.

### [fwupd-GUI](https://github.com/trytomakeyouprivate/fwupd-GUI)
Firmware updates dependend on a save batterystate and AC conection.

You get asked via a window and can accept or postpone.

currenty not finished.

### [Easy bash loop helper](https://github.com/trytomakeyouprivate/easy-bash-loops)
This tool interactively allows you to create yes/no loops for interactive scripts. This means the user gets asked a question, and you can enter what happens if yes/no is entered.

It supports copying the result to clipboard (for use in scripts) or save it to a file.

### [Polkit-helper](https://github.com/trytomakeyouprivate/Polkit-helper)

Easily create polkit rules so that you dont need to enter a password to launch e.g. Virt-manager or mount LUKS drives.

Use sparely!

Needs revisioning currently-

### [Flatpak-updater](https://github.com/trytomakeyouprivate/Flatpak-updater)

Keep your Flatpak apps updated via a systemd service

[Simpler alternative to this python script](https://gist.github.com/ssokolow/db565fd8a82d6002baada946adb81f68) working with aliases instead of runfiles.

### flatalias

A simple tool that lists your installed flatpaks and aliases a cleaned up name to your bashrc, zshrc and fish config.

It recognizes existing aliases, so you can easily run it hourly with a systemd service.

### cd2

The better but simple Linux Filemanager Terminal experience.

It combines
- cd command for moving directories
- ls command for listing contencts
- a nice display of the current location

using custom shortcuts you can modify the ls output to 
- sort files by size
- sort files "newest first"
- show advanced info

currently broken

### [apkverify](https://github.com/trytomakeyouprivate/Android-Tipps/tree/main/APK-Signer)
A tool to easily verify if an Android app is secure.

`apkverify test.apk`

### logout
For some reason this is way too complicated.

Logging out from a graphical Desktop through the terminal is not standard.

This command logs you out from a KDE Wayland session.

### findmod

a combination of `whereis` and your editor of choice, in my case "Kate"

just type `findmod sysinfo` and it opens up!

### [flatpurge (currently not ready)](https://github.com/trytomakeyouprivate/Flatpak-trash-remover)

Find leftover directories of deleted Flatpak apps and allow you to remove them

Interactively of course, nothing deleted without consent

### [Flatpak binary linker](https://github.com/trytomakeyouprivate/Linux/blob/main/Scripts/Flatpak-binaries)

This script searches for some Flatpak apps and links binaries like ffmpeg to ~/.bin, where the user can directly access them.


### Keelock
A customizable command for unlocking a KeepassXC Wallet with a password stored in KWallet.

For sure this could also be extended to Gnome wallet, feel free to do so

### [Distrobox-autosetup](https://github.com/trytomakeyouprivate/Distrobox-autosetup)

Setup scripts for some common Linux environments.

Using Distrobox you can run any Linux app on every Linux Distro supporting Podman.

### [Security-shutdown](https://github.com/trytomakeyouprivate/Security-shutdown)

Various ways to detect that the power source is removed, shutdown the machine in that case.

Useful for servers with a buffer battery or other scenarios.

### git-clone-all
Enter a user or group, clone all repositories

### mic-set
Problem: Your microphone is overamplified.

This script can be run in `~/.config/autostart/` and set your mic volume to 40% and mute it.

It workes on pulseaudio systems. Not sure about pipewire.

### website-language-checker
Useful for creating Lists of Websites with domains for specific languages.

Used for creating KDE Search engine .desktop files, but can easily be extended.

### [Mullvad-Reminder](https://github.com/trytomakeyouprivate/Mullvad-Reminder)
currently for some reason not working.

Goal: keep the GUI app open (shown in apptray) if the VPN is disconnected, so that you dont forget to connect again.

### [Systemd-hold-active](https://github.com/trytomakeyouprivate/systemd-hold-active)
Experimental, currently not working

Idea: Enable a service, launch an app, disable the service again when app is closed.

Useful for temporarily enabling CUPS, Bluetooth e.g.

### [Matlab GUI system integration](https://github.com/trytomakeyouprivate/Matlab-Linux-Install)
- fish, bash, zsh integration
- linking of the binary
- creating an appstarter
- setting mimetype so .m files should be opened automatically

### remove

a simple tool for removing .exe, .bat and .dmg files from archives you Downloaded.

This is useful if you have an archive for a program running on Linux, Windows and mac

### utf8 
A small command that just sets your locale to your Language UTF8.

Useful if you have bugs because of messing up your language

### mkexec
never type in `chmod +x FILENAME` again!
