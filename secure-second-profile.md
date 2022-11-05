# Create an isolated guest profile

Maybe you want to allow guests to do basic browsing or complete usage of your device. If you dont trust these people or you generally want to secure them from doing anything stupid, here is how it works:

## 0. Word explanations
**root**: has access over all files on your laptop

**su**: using root privileges.

**sudo**: a way to use root privileges as a normal user, you need the root password for that. Standard behavior.

### Home directory
This is the folder in which a normal user can write. It is recommended to stay in this directory all the time when possible. Only normal exception is the install/ updating of apps, which can be automated.

in commands instead of `/home/USERNAME/` you can write `~/`

your `/home/USERNAME/` folder, where all your files are stored. You can access all the files in there without sudo permissions!
- Folders you create like **Pictures, Downloads, Files,...*
- The **Nextcloud** folder, that `nextcloud-client` (The end-user app) uses for synchronisation
- in `~/.config/`: config files of apps like **Firefox** Profiles, **Thunderbird**, **KDE Desktop**, ...
- in `~/.wine/`: your complete Windows-filesystem with apps e.g. when using WINE
- in `~/.var/app/` all Flatpak app data is stored
- in `~/.ssh/` all SSH-keys are, used for remote control over a terminal
- in `~/.gnupg/` all your PGP-keys are

So you can do pretty much everything in the userspace, and guest users should do even more, so that they cannot break your system.

## Root or normal user?
root users can edit anything stored in `/`, the complete filesystem. This user should be secured with a pretty strong password, depending on your threat-model.

Use a normal user for your guest.

## Problem: Read-access to your files
On linux the normal configuration is, that other users can view every filesystem in `/home/`, so they can view all your files, just not edit or delete them.

You can solve this problem with one command:

```chmod 700 /home/USERNAME```

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

Graphically you can do this in the Dolphin-Filemanager of KDE by going to `/home/` and right-clicking on the Folder "USERNAME", switching to "Permissions", setting the owner to "user" and the access of "group" and "others" to "no access".

Nautilus will have something for that too.
