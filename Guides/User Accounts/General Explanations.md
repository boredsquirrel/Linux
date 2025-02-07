## 1. Word explanations
**root**: has access over all files on your laptop

**su**: using root privileges.

**sudo**: a way to use root privileges as a normal user, you need the root 
password for that. Standard behavior.

**flatpak**: containerized apps you can install and uninstall without root 
privileges. They are also safer and mostly can't break your system

**native app**: an app developed on the resources your Linux distro offers, 
without any extra runtime etc. It uses your system and can break it that way.

## 2. Home directory
This is the folder in which a normal user can write. It is recommended to stay 
in this directory all the time when possible. Only normal exception is the 
install/ updating of app.

- this can be automated so the user doesn't have to know the root password
- prefer Flatpaks if available, you dont need root to install, uninstall, or 
modify them

in commands instead of `/home/<username>/` you can write `~/`. This also works 
on distros like Fedora Silverblue/Kionite, where 
`/home/username/` is in `/var/home/username/`

In your home folder, all your files are stored. You can access everything in 
there without sudo permissions!
- Folders you create like **Pictures, Downloads, Files,...**
- The **Nextcloud** folder, that `nextcloud-client` (The end-user app) uses for 
synchronisation
- in `~/.config/`: config files of apps like **Firefox** Profiles, 
**Thunderbird**, **KDE Desktop**, ...
- in `~/.wine/`: your complete Windows-filesystem with apps e.g. when using WINE
- in `~/.var/app/` all Flatpak app data is stored
- in `~/.ssh/` all SSH-keys are, used for remote control over a terminal
- in `~/.gnupg/` all your PGP-keys are

So you can do pretty much everything in the userspace, and guest users should 
do even more, so that they cannot break your system.

## 3. Root, wheel/sudo or normal user?

### Root
root users can edit anything stored in `/`, the complete filesystem. This user 
should be secured with a pretty strong password, depending on your 
threat-model. Dont use the root user for anything, except needed. This is the 
default on Linux, so if you dont't know which user you are, you are not root.

Use a normal user for your guest, when creating a second profile under 
"Settings -> Profiles" or similar.

### wheel/sudo
This group determines if a user is allowed to execute commands as `root` by 
entering their password.

If a program is able to execute code from within such a user, a "[privilege 
escalation](https://en.wikipedia.org/wiki/Privilege_escalation)" is easily 
possible.

This is why your daily user should not be in the `sudo` (Debian, Ubuntu) or 
`wheel` group.

Check it with `id`:

```
❯❯❯ id
uid=1003(user) gid=1004(user) Gruppen=1004(user),1012(usbguard) 
Kontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

To create a separate admin user, follow the Guide "secure admin user" in this 
directory.


## 4. UNIX file permissions

This command works with any location of the home directory, e.g. Fedora 
Silverblue/Kionite too.

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

Graphically you can do this in the Dolphin-Filemanager of KDE by going to 
`/home/` or `/var/home/` respectively and right-clicking on the Folder 
"USERNAME", switching to "Permissions", setting the owner to "USERNAME" and the 
access of "group" and "others" to "no access" instead of "read only".

Nautilus will have something for that too.

## 5. SELinux contexts and groups

### User apps
No Desktop Linux distro uses SELinux for user programs to it's full 
capabilities, unlike Android, where SELinux (also called "SEAndroid") is a core 
part of the App sandbox.

The Fedora project is working on "selinux confined users", you can follow the 
process here:

- [Fedora confined users 
documentation](https://fedoraproject.org/wiki/SELinux/ConfinedUsers)
- [Forum 
tag](https://discussion.fedoraproject.org/search?q=%23selinux-confined-users%20o
rder%3Alatest)
- [Fedora SELinux policy repo](https://github.com/fedora-selinux/selinux-policy)

### System files
This is where SELinux is used a lot though.

Using the `-Z` flag you can make a lot of coreutils "SELinux aware", example 
`ls`:

```
cd /
ls -lZ
lrwxrwxrwx.   7 root root system_u:object_r:bin_t:s0           7  4. Dez 2023  
bin -> usr/bin/
drwxr-xr-x.   7 root root system_u:object_r:boot_t:s0       4096 25. Jan 13:16 
boot/
drwxr-xr-x.  20 root root system_u:object_r:device_t:s0     4700  6. Feb 12:12 
dev/
drwxr-xr-x.   1 root root system_u:object_r:etc_t:s0        4750 29. Jan 22:20 
etc/
lrwxrwxrwx.   4 root root system_u:object_r:home_root_t:s0     8  4. Dez 2023  
home -> var/home/
lrwxrwxrwx.   7 root root system_u:object_r:lib_t:s0           7  4. Dez 2023  
lib -> usr/lib/
lrwxrwxrwx.   4 root root system_u:object_r:lib_t:s0           9  4. Dez 2023  
lib64 -> usr/lib64/
lrwxrwxrwx.   4 root root system_u:object_r:mnt_t:s0           9  4. Dez 2023  
media -> run/media/
lrwxrwxrwx.   4 root root system_u:object_r:mnt_t:s0           7  4. Dez 2023  
mnt -> var/mnt/
lrwxrwxrwx.   4 root root system_u:object_r:usr_t:s0           7  4. Dez 2023  
opt -> var/opt/
lrwxrwxrwx.   5 root root system_u:object_r:usr_t:s0          14  4. Dez 2023  
ostree -> sysroot/ostree/
dr-xr-xr-x. 471 root root system_u:object_r:proc_t:s0          0 30. Jan 11:24 
proc/
lrwxrwxrwx.   4 root root system_u:object_r:admin_home_t:s0   12  4. Dez 2023  
root -> var/roothome/
drwxr-xr-x.  57 root root system_u:object_r:var_run_t:s0    1480  5. Feb 12:59 
run/
lrwxrwxrwx.   7 root root system_u:object_r:bin_t:s0           8  4. Dez 2023  
sbin -> usr/sbin/
lrwxrwxrwx.   4 root root system_u:object_r:var_t:s0           7  4. Dez 2023  
srv -> var/srv/
dr-xr-xr-x.  13 root root system_u:object_r:sysfs_t:s0         0 30. Jan 10:26 
sys/
drwxr-xr-x.   1 root root system_u:object_r:root_t:s0         74  4. Dez 2023  
sysroot/
drwxrwxrwt.  56 root root system_u:object_r:tmp_t:s0        1240  6. Feb 13:50 
tmp/
drwxr-xr-x.   1 root root system_u:object_r:usr_t:s0         106  1. Jan 1970  
usr/
drwxr-xr-x.   1 root root system_u:object_r:var_t:s0         266 29. Jan 22:20 
var/
```

This shows the different contexts of system files, and setting them correctly 
can act as an extra protection.

For example if you edit a config file in `/etc`:

```
# create an overwrite directory

mkdir /etc/systemd/resolved.conf.d
cd /etc/systemd/resolved.conf.d

# write an overwrite config here:

cat > private-dns.conf <<EOF
[Resolved]
DNSSEC=yes
DNSOverTLS=yes
DNS=185.150.99.255 5.1.66.255 2001:678:e68:f000:: 2001:678:ed0:f000::
FallbackDNS=9.9.9.9 149.112.112.112
EOF
```

This sets a "trustworthy DNS provider" as per [these 
2](https://www.privacy-handbuch.de/handbuch_93d.htm) 
[websites](https://www.heise.de/ratgeber/DNSSEC-Know-how-Werkzeuge-und-Software-
fuer-den-Administrator-2643530.html), which has support for DNSSEC and DOT (DNS 
over TLS). As fallback DNS, Quad9 is used. DNSSEC and DOT are protection 
mechanisms that encrypt the DNS and help against 
[spoofing](https://en.wikipedia.org/wiki/Spoofing_attack) and traffic analysis 
from the DNS provider.

If we now look at the resulting config file, we see that the SELinux labels are 
incorrect.

```
ls -lZ
-rw-r--r--. 1 root root unconfined_u:object_r:etc_t:s0 143  6. Feb 14:20 
private-dns.conf
```

Look at `unconfined_u`, this means that ***no SELinux protection is used***. 
Instead, all systemwide config files should have the label 
`system_u:object_r:etc_t:s0`.

Normally this can be automatically fixed with the `restorecon` tool:

```
restorecon -R /path/that/has/incorrect/labels
```

But in many cases, especially such override config files seem to not have a 
default value.

Instead, check the values it *should* have (in this case 
`system_u:object_r:etc_t:s0`) and apply it manually

```
chcon -R system_u:object_r:etc_t:s0 /etc/systemd/resolved.conf.d
```
