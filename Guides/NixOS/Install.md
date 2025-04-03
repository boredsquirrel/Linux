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
btrfs subvolume create /mnt/nix

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

### 2.1 Main configuration.nix
Edit the main config file

```
cd /mnt/etc/nixos
mkdir configuration
nano configuration.nix
```

Replace the part at the top, loading the hardware configuration, with this:

```
{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration/packages.nix
      ./configuration/kde-plasma.nix
      # ./configuration/unstable-packages.nix
    ];
...
```

Apart from that, change as little as possible in that file.

### 2.2 Specific config files

Separate out other config snippets to keep it clean.

In this example, additional packages and KDE Plasma are separated out.

#### 2.2.1 KDE Plasma Config File

```
nano configuration/kde-plasma.nix
```

Add something like this here

```
{ config, lib, pkgs, ... }:

{

    # KDE Plasma 6 and SDDM
    services.displayManager.sddm.enable = true ;
    services.desktopManager.plasma6.enable = true ;

    # KDE Plasma in Wayland
    services.displayManager.defaultSession = "plasma" ;

    # SDDM in Wayland
    services.displayManager.sddm.wayland.enable = true ;

    # KDE Plasma
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    xwaylandvideobridge
    ];

    # KDE Partitionmanager
    programs.partition-manager.enable = true;

    # programs.kdeconnect.package = true;
    programs.kdeconnect.enable = true;
}
```

#### 2.2.2 Packages

```
nano configuration/packgages.nix
```

example:

```
{ config, lib, pkgs, ... }:

{
    programs.firefox.enable = true;

    # syncthing
    services.syncthing.enable = true;

    # localsend
    programs.localsend.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        wget
        aria2
        curl
        git
        nano
        htop
        btop
        powertop
        cosmic-term
        kate
        haruna
    ];
}
```

#### 2.2.3 Unstable Packages
This does not work yet, unsure if you can add the unstable branch at installation.

NixOS is stable by default, with updates every 6 months. Meanwhile, the packages are actually updated very frequently, and the `unstable` branch allows to use these. Switching to it entirely is often recommended, but can introduce instability, the packages are about as new as on Arch Linux.

So an alternative is to mix stable and unstable. Note that a ton of dependencies will be duplicated, which slows down updates and increases storage size.

Example:

```
{ config, lib, pkgs, ... }:

let
    unst = import <nixos-unstable> {};
in
{
    # Mullvad
    services.mullvad-vpn.package = unst.mullvad-vpn;
    services.mullvad-vpn.enable = true ;
    
    # Fish Shell
    programs.fish.package = unst.fish;
    programs.fish.enable = true;
    programs.fish.vendor.functions.enable = true;
    programs.fish.vendor.completions.enable = true;
    programs.fish.vendor.config.enable = true;
    
    # Flatpak
    services.flatpak.package = unst.flatpak;
    services.flatpak.enable = true;
}
```

To enable this (after installation), add the unstable channel and update the channels.

```
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
sudo nix-channel --update

# then remove the comment in the main configuration.nix
# now rebuild the system

sudo nixos-rebuild switch
```

### 2.3 Hardware Config

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

See what packages are missing, add them to the config files.

## 6. Stable vs. Unstable

If you want to replace the stable channel with the unstable one, override the default `nixos` channel.

```
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos
sudo nix-channel --update
sudo nixos-rebuild switch
```

This will rebuild the OS and swap out the packages with the unstable ones.

To revert, you need to add a point release channel, currently 24.11

```
sudo nix-channel --add https://channels.nixos.org/nixos-24.11 nixos
sudo nix-channel --update
sudo nixos-rebuild switch
```
