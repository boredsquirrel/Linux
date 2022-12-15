# Create an isolated guest profile

Maybe you want to allow guests to do basic browsing or complete usage of your device. If you dont trust these people or you generally want to secure them from doing anything stupid, here is how it works:

## 0. Word explanations
**root**: has access over all files on your laptop

**su**: using root privileges.

**sudo**: a way to use root privileges as a normal user, you need the root password for that. Standard behavior.

**flatpak**: containerized apps you can install and uninstall without root privileges. They are also safer and mostly can't break your system

**native app**: an app developed on the resources your Linux distro offers, without any extra runtime etc. It uses your system and can break it that way.

## 1. Home directory
This is the folder in which a normal user can write. It is recommended to stay in this directory all the time when possible. Only normal exception is the install/ updating of app.

- this can be automated so the user doesn't have to know the root password
- prefer Flatpaks if available, you dont need root to install, uninstall, or modify them

in commands instead of `/home/<username>/` you can write `~/`. This also works on distros like Fedora Silverblue/Kionite, where 
`/home/username/` is in `/var/home/username/`

In your home folder, all your files are stored. You can access everything in there without sudo permissions!
- Folders you create like **Pictures, Downloads, Files,...**
- The **Nextcloud** folder, that `nextcloud-client` (The end-user app) uses for synchronisation
- in `~/.config/`: config files of apps like **Firefox** Profiles, **Thunderbird**, **KDE Desktop**, ...
- in `~/.wine/`: your complete Windows-filesystem with apps e.g. when using WINE
- in `~/.var/app/` all Flatpak app data is stored
- in `~/.ssh/` all SSH-keys are, used for remote control over a terminal
- in `~/.gnupg/` all your PGP-keys are

So you can do pretty much everything in the userspace, and guest users should do even more, so that they cannot break your system.

## 2. Root or normal user?
root users can edit anything stored in `/`, the complete filesystem. This user should be secured with a pretty strong password, depending on your threat-model. Dont use the root user for anything, except needed. This is the default on Linux, so if you dont't know which user you are, you are not root.

(You can enter an X11-session by pressing `Ctrl+Alt+4` on the login screen, logging in and writing `sudo startx`. But don't use that, except there is no other way, maybe because you broke your user profile.

You can also use Dolphin File manager with root entering `pkexec env 'DISPLAY=$DISPLAY' 'XAUTHORITY=$XAUTHORITY' KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true dolphin`. This can be useful for editing some files, but use it only when nessecary.

Use a normal user for your guest, when creating a second profile under "Settings -> Profiles" or similar.

## 3. Problem: Read-access to your files
On linux the normal configuration is, that other users can view every filesystem in `/home/`, so they can view all your files, just not edit or delete them.

You can solve this problem with one command:

```chmod 700 ~/```

This command works with any location of the home directory, e.g. Fedora Silverblue/Kionite too.

An explaining table of the values:
```
r/w/x | binary | octal
 ---  |  000   |   0
 --x  |  001   |   1
 -w-  |  010   |   2
 -wx  |  011   |   3
 r--  |  100   |   4
 r-x  |  101   |   5
 rw-  |  110   |   6
 rwx  |  111   |   7
```

So "user" has rwx (read write delete) permissions, and the others have none.

Graphically you can do this in the Dolphin-Filemanager of KDE by going to `/home/` or `/var/home/` respectively and right-clicking on the Folder "USERNAME", switching to "Permissions", setting the owner to "USERNAME" and the access of "group" and "others" to "no access" instead of "read only".

Nautilus will have something for that too.

## 4. Only safe with LUKS disk encryption

Now other users won't be able to view your files anymore and can safely use your computer, if you have also enabled `LUKS` or `LVM encryption` with a good startup at system setup.

Always encrypt your whole drive, performance is perfect and its the only way to secure your files really, as anyone could plug out your drive and view it on another computer with sudo rights.
