# Create an isolated guest profile

Maybe you want to allow guests to do basic browsing or complete usage of your device. If you dont trust these people or you generally want to secure them from doing anything stupid, here is how it works:

## 1. Create a new user

To add a user from the terminal, use this command:

```
# select between sudo and run0
if [[ $(systemctl --version | awk 'NR==1{print $2}') -ge 256 ]]; then
    alias privesc=run0
else
    alias privesc=sudo
fi
    
privesc sh -c '
read -p "Enter the name of the second user" username
useradd $username
passwd $username
'
```

Alternatively you can add them from your settings app. This works at least in KDE Plasma, GNOME and COSMIC.

## 1. Problem: Read-access to your files

On linux the normal configuration is, that other users can view every filesystem in `/home/`, so they can view all your files, just not edit or delete them.

You can solve this problem with one command:

```
chmod 700 ~
```

## 2. Only safe with LUKS disk encryption

Now other users won't be able to view your files anymore and can safely use your computer, if you have also enabled `LUKS` or `LVM encryption` with a good password at system setup.

Always encrypt your whole drive, performance is perfect and its the only way to secure your files really, as anyone could plug out your drive and view it on another computer with sudo rights.

You can add different LUKS encryption keys, so you don't need to share your password:

```
lsblk

cryptsetup luksAddKey /dev/DEVICENAME
```

If you want to change your LUKS password, use this:

```
cryptsetup luksChangeKey /dev/DEVICENAME
```

This is possible because the password is only used to decrypt the actual key used to encrypt your disk.

## 3. Encrypted user accounts
Logging out does not encrypt the user data, unlike on Android for example.

This is pretty bad, so you want to encrypt the user data, if you use "logging out" as a security mechanism

### 3.1 systemd-homed
While separate user account encryption is possible using various utilities, `systemd-homed` may be the variant that is soonest built-in in your distribution.

Currently it is all experimental though, so be sure to have backups!
