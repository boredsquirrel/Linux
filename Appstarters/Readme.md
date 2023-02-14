Using Linux often requires some technical knowledge. And that is fine, learn what you want. But many people are afraid of that, so "Appstarters" are awesome! You can create an "app" containing any command, and use that app to do a lot of stuff.

I made a few ones, automating some tasks so that I dont have to open the terminal.

**Tip**: If you want to open files always with one of the appstarters, choose the `open with -> other applications -> *choose appstarter* -> always use that application` dialog by right-clicking.

# List of useful appstarters

## General
**Bluetooth**: If your machine has bluetooth disabled or it is off for some reason, this app activates it

**Hibernate**: If your system supports it, this will shut down your PC but restore everything on startup. Not integrated by default in many distros.

## Applications
**Firefox Profiles**: This is an example of how to launch apps with parameters. Opening Firefox with `firefox -P` opens the chooser, using `firefox -P NAME` opens the profile "NAME".

**Element profiles**: This is a hidden feature. Only using this launch parameter you can have many accounts on Element parallel.

**Make-executable**: Sometimes you download .appimage, .jar or .py Apps, shell scripts or anything. You can make them able to open using that appstarter.

**Dolphin-root**: Dangerous, but comfortable to edit some folders and files with sudo permissions. ***Only use when nessecary!*** Works on Wayland

**Betterbird**: A custom version of Thunderbird with Outlook-style lines e.g., available as a Flatpak. I just don't like the icon, so this is an example how to replace the icon (Note: you have to remove the original .desktop file from the ~/.var/app/eu.betterbird.Betterbird/ folder to make it work normally, after that the icon somehow is not restored after updates)

**KeepassXC-unlock**: KeepassXC is still not detected by KWallet, which would otherwise insert the stored password and open the database automatically. This is really useful though, so here is how to do it:

1. Open "KWalletManager"
2. Your wallet should be called "kdewallet", if not create a new one with that name, or edit the Appstarter
3. If you see a folder "Passwords", you can proceed. If not, right-click to create one
4. In this "Passwords" folder should be another "Passwords" folder, written in your local language. Inside that folder you create a new entry called "Keepass"
5. Click on "show content" and insert your databases password
6. Edit the appstarter to open exactly your database instead of the generic path (~/passwords.kdbx)

##  Install apps
**Debian-based (Ubuntu, Linux mint, MXLinux, ...)**
**DEB-Install**: install a .deb Application directly from the terminal, way faster than Discover or Gnome Software (using dpkg)

**RedHat/Fedora based (Fedora, RockyLinux, RHEL, ...)**
**RPM-Install**: install a .rpm Application in the Terminal (using dnf)

you can extend this of course. I could not make this work well with rpm-ostree, but this is also not recommended as one install takes really long, prefer instaling all wanted apps at once (and also install as little as possible directly to your system, use Flatpaks or Containers)

#### Android (ADB)
If you use ADB via a connected android device, you can install apps (.apk) through the terminal and automate smartphone setups by that.

***ADB-install**: requires "adb" to be installed, installs the .apk directly to the device

#### Waydroid
This uses the `waydroid app install` command, to install an .apk directly to the Android container

### Basics
Appstarters can be found in  /home/USERNAME/.local/share/applications (also written as ~/.local/share/applications). You can edit this folder without root permissions, so its perfect.

An appstarter is just a text file, referring to an image, a command and containing names and descriptions, often in many languages. I made mine only in english, feel free to edit them. The language will be english if its your local or there is no other available.

### Tip: create Appstarters for .appimage, .py, .jar Apps
Some apps are only available as Appimages, meaning you have to execute the file to open the app. This can be made easier, if you create an appstarter with the command being just the adress of the file. Example:

`~/Programs/Appimages/Session.appimage`

You can create your own Appstarters in the KDE Menueditor.

### Distrobox
This nice tool, forked from Toolbox, allows you to run many Linux distros inside a host Distro using Podman. That way you can use all Apps from Ubuntu, Fedora or Arch on any Distro you like. You can run GUI-Apps, just not really whole Desktops. It doesnt use Virtual machines, so it feels pretty native. The containers are not isolated from the `/home/` filesystem though!

Distrobox creates nice looking Appstarters for new containers on its own. They have the name you gave the container.
