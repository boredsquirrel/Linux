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

### Energysaver
Two scripts that are part of a UDEV-rule + Systemd-service + Script complex

Goal is:

1. Detect Battery and AC state
2. If Energysaving mode is useful, deactivate random CPU cores
3. On AC activate all cores again

This works on all systems where TLP doesnt work.

### flatpak-permission-cleaner
Many Flatpak apps have whole root access over your system for compatibility.

Replace these permissions with 

- home
- mounted drives
- smb shares
- ...


### [copr](https://github.com/trytomakeyouprivate/COPR-command)
Add COPR repos on Fedora without using DNF.

Useful if you are on Fedora Kinoite/Silverblue/Sericea/...

### Rsync helper

Backup software on Linux is kind of a struggle. Many nice GUI tools available, but they are often bloated, dont run in the background reliably or waste resources.

Rsync is already integrated in most Linux distros and supports offline backups perfectly.

This script helps you to setup your own Rsync service, running automatically, with specified Location and so on.

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

### logout
For some reason this is way too complicated.

Logging out from a graphical Desktop through the terminal is not standard.

This command logs you out from a KDE Wayland session.

### findmod

a combination of `whereis` and your editor of choice, in my case "Kate"

just type `findmod sysinfo` and it opens up!

### flatpurge (currently not ready)

Find leftover directories of deleted Flatpak apps and allow you to remove them

Interactively of course, nothing deleted without consent

### Keelock
A customizable command for unlocking a KeepassXC Wallet with a password stored in KWallet.

For sure this could also be extended to Gnome wallet, feel free to do so

### git-clone-all
Enter a user or group, clone all repositories

### website-language-checker
Useful for creating Lists of Websites with domains for specific languages.

Used for creating KDE Search engine .desktop files, but can easily be extended.

### remove

a simple tool for removing .exe, .bat and .dmg files from archives you Downloaded.

This is useful if you have an archive for a program running on Linux, Windows and mac

### utf8 
A small command that just sets your locale to your Language UTF8.

Useful if you have bugs because of messing up your language

### mkexec
never type in `chmod +x FILENAME` again!
