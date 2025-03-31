# NixOS Install

Minimal Install ISO

https://nixos.org/download/

Manual:

https://nixos.wiki/wiki/NixOS_Installation_Guide

```
sudo -i

# setting up german keyboard layout
loadkeys de
```

## 1. Network

```
iwconfig

# taking wlp3s0 as wifi interface

iwconfig wlp3s0 up

iwlist wlp3s0 scan | grep ESSID

# wpa supplicant

systemctl start wpa_supplicant

wpa_passphrase ESSID PASSPHRASE > /etc/wpa_supplicant.conf

wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp3s0 &
```

may still run in foreground, other TTY session (Ctrl+Alt+Fx)

test

```
ping wikipedia.org
```

## 2. Partitions

## fdisk

```
lsblk

fdisk

# delete partitions

d # delete all of them

# new, EFI for boot
n # start 2048, end +600M

# main
n # start, end default

### change types

# Linux filesystem  20
# EFI boot          1
t
```

## Filesystems

```
lsblk
```

### EFI BOOT

```
mkfs.vfat -F32 /dev/DEVICE1

fatlabel /dev/DEVICE1 NIXBOOT
```

### LUKS

serpent: best but not accelerated, intel processors accelerate AES encryption

```
cryptsetup luksFormat -y -c aes-xts-plain64 -s 512 /dev/DEVICE2

# YES

cryptsetup luksOpen /dev/DEVICE2 luksdev
```

### BTRFS

```
mkfs.btrfs -L NIXROOT /dev/mapper/luksdev
```

### Mount

```
mkdir -p /mnt/boot

mount /dev/mapper/luksdev /mnt

mount /dev/DEVICE1 /mnt/boot

chmod -R 700 /mnt/boot
```

### BTRFS Subvolumes

```
btrfs subvolume create /mnt/root

btrfs subvolume create /mnt/usr

btrfs subvolume create /mnt/etc

btrfs subvolume create /mnt/var

btrfs subvolume create /mnt/var/tmp

chmod 1777 /mnt/var/tmp

btrfs subvolume create /mnt/snapshots

btrfs subvolume create /mnt/home

btrfs subvolume list /mnt
```

### SWAP file

```
dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=4097152 # 4GB size
chmod 600 /mnt/.swapfile
mkswap /mnt/.swapfile
swapon /mnt/.swapfile
```

## 2. Config

Generate a default config
```
nixos-generate-config --root /mnt
```

Edit the config and add the parts from "kde.nix".

```
nano /mnt/etc/nixos/configuration.nix
```

enable bluetooth

```
nano /mnt/etc/nixos/hardware-configuration.nix
```

## 3. Install

Make sure that you set a root password. If you are not asked one, repeat the `nixos-install` command

```
cd /mnt
nixos-install
```

## 4. User Password

The user has no password. Exit to TTY2 (Ctrl+Alt+F2)

Login as root, you should know the root password

```
passwd user
```

## 5. Test the system

See what packages are missing, add them to the packages section
