# - - - - - - - - Linux-Help - - - - - - - - 
Some little things that make Linux distros easier to use!

## 1. Creating a safe profile

When you want other people to use your machine, in a secure way.

## 2. Appstarters

Using Linux often requires some technical knowledge. And that is fine, learn what you want. But many people are afraid of that, so "Appstarters" are awesome! You can create an "app" containing any command, and use that app to do a lot of stuff.

I made a few ones, automating some tasks so that I dont have to open the terminal.

**Tip**: If you want to open files always with one of the appstarters, choose the `open with -> other applications -> *choose appstarter* -> always use that application` dialog by right-clicking.

### List of useful appstarters

#### General
**Bluetooth**: If your machine has bluetooth disabled or it is off for some reason, this app activates it

**Hibernate**: If your system supports it, this will shut down your PC but restore everything on startup. Not integrated by default in many distros.

#### Applications
**Make-executable**: Sometimes you download .appimage, .jar or .py Apps, shell scripts or anything. You can make them able to open using that appstarter.

**Dolphin-root**: Dangerous, but comfortable to edit some folders and files with sudo permissions. ***Only use when nessecary!*** Works on Wayland

**Betterbird**: A custom version of Thunderbird with Outlook-style lines e.g., available as a Flatpak. I just don't like the icon, so this is an example how to replace the icon

**Handbrake-POWER**: using "taskset -c 0,1,2,3" you can assign multiple CPU cores to a resource-intensive program

#### Debian-based (Ubuntu, Linux mint, MXLinux, ...)
**DEB-Install**: install a .deb Application directly from the terminal, way faster than Discover or Gnome Software (using dpkg)

#### RedHat/SUSE based (Fedora, RockyLinux, RHEL, OpenSuse, ...)
**RPM-Install**: install a .rpm Application in the Terminal (using dnf)

#### Android (ADB)
If you use ADB via a connected android device, you can install apps (.apk) through the terminal and automate smartphone setups by that.

***ADB-install**: requires "adb" to be installed, installs the .apk directly to the device

### Basics
Appstarters can be found in  /home/USERNAME/.local/share/applications (also written as ~/.local/share/applications). You can edit this folder without root permissions, so its perfect.

An appstarter ist just a textfile, referring to an image, a command and containing names and descriptions, often in many languages. I made mine only in english, feel free to edit them.

### Tip: create Appstarters for .appimage, .py, .jar Apps
Some apps are only available as Appimages, meaning you have to execute the file to open the app. This can be made easier, if you create an appstarter with the command being just the adress of the file. Example:

`~/Programs/Appimages/Session.appimage`

You can create your own Appstarters in the KDE Menueditor.
---

## 3. Setup-Scripts
Setting up a Linux Distribution is more work than just installing the System. You will have to install and uninstall a lot of apps, and set some settings.
[Here is a cool example of creating a minimal Fedora KDE Operating System, without anything not wanted installed](https://www.reddit.com/r/Fedora/comments/9a0i93/howto_minimal_kde_install_on_fedora/)

I have created my own scripts for Kubuntu/KDE Neon, Fedora KDE, Fedora Kionite and RockyLinux (superstable Desktop or server).

The scripts include:

1. Uninstalling unwanted apps
2. Adding the Flatpak repository Flathub
3. Optional: adding Snap repo
4. Installing basic apps (some are better replacements of previously uninstalled apps!)
5. Get external apps (.deb or .rpm respectively) and download them (check integrity yourself! I have no automatic checks yet)
6. Set some settings (complete hardening only on RockyLinux)
