# Fedora Kinoite Einrichtung
Kinoite ist eine sehr gute Distribution: KDE Desktop, aktuelle Software, sehr sicher, schnelle Updates mit Backup-Funktion.

Ublue.it ist notwendig, da Fedora keine unfreie Software wie Media-Codecs (Videos) oder NVIDIA-Treiber mitinstallieren kann. Die Entwickler bei ublue machen das für uns.

## Installieren

Download vom [kinoite.fedoraproject.org](kinoite.fedoraproject.org) , brennen mit [Balena Etcher](https://etcher.balena.io/#download-etcher) oder [Fedora Media Writer](https://flathub.org/apps/org.fedoraproject.MediaWriter). Ventoy funktioniert eventuell nicht.

Wichtig:

- Keinen Root-account erstellen
- LUKS bei "Speicher" aktivieren, Festplattenverschlüsselung
- Sehr sicheres LUKS-Passwort, normales user-Passwort

# Nach der Installation

Schnell:

Nicht-NVIDIA-Grafikkarte:
```
wget https://github.com/trytomakeyouprivate/Linux/raw/main/Setupscripts/Fedora-Kinoite-Setup | sudo bash

echo "Rebasing to ublue Fedora Kinoite. This will take a while, the machine will shutdown afterwards."
echo
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/kinoite-main:38 && shutdown -h now
```

NVIDIA-Grafikkarte:

```
wget https://github.com/trytomakeyouprivate/Linux/raw/main/Setupscripts/Fedora-Kinoite-Setup- | sudo bash

echo "Rebasing to ublue Fedora Kinoite. This will take a while, the machine will shutdown afterwards."
echo
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/kinoite-nvidia:38 && shutdown -h now
```

# Manuell:

Zu ublue-Kinoite wechseln:

normal
```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/kinoite-main:38 && reboot
```

NVIDIA:
```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/kinoite-nvidia:38 && reboot
```

### Nach dem Neustart

```
echo "replace Fedora Flatpak with Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete fedora -y

echo "Install some nice Apps"
flatpak install -y vlc syncthingy simplescan nextcloud thunderbird org.libreoffice.LibreOffice keepassxc kfind clipqr com.github.jeromerobert.pdfarranger element com.github.micahflee.torbrowser-launcher org.cryptomator.Cryptomator org.fontforge.FontForge org.freefilesync.FreeFileSync org.gnome.Snapshot org.onionshare.OnionShare org.signal.Signal page.codeberg.JakobDev.jdFlatpakSnapshot gimp

echo "refresh Disvover sources"
pkcon refresh

echo "Deactivate Baloo"
balooctl disable && balooctl purge

echo "create useful distroboxes and install packages"
distrobox create Ubuntu -i docker.io/library/ubuntu:22.04 && distrobox enter Ubuntu -- exit

distrobox create fedora -i registry.fedoraproject.org/fedora-toolbox:37 && distrobox enter Fedora -- exit

echo "disable Geoclue location service"
sudo systemctl disable geoclue

# echo "Disable Discover"
# sudo systemctl disable DiscoverNotifier #if using Flatpak and Firmware autoupdates

sudo systemctl enable podman-auto-update.service #autoupdates for Distroboxes
sudo systemctl enable rpm-ostreed-automatic.timer #automatic system updates

echo "Adding some nice shortcuts"

cat >> ~/.bashrc <<EOF

# Some nice Bash shortcuts for easy usage


alias logout="shopt -q login_shell && logout || qdbus org.kde.ksmserver /KSMServer logout 0 0 1"
alias update='flatpak update -y && notify-send -a "Updates" "Flatpaks updated" ; rpm-ostree update'
alias upfin='flatpak update -y && notify-send -a "Updates" "Flatpaks updated" ; rpm-ostree update && shutdown -h now'
alias rstat="rpm-ostree status"
alias install="rpm-ostree install"
alias firmwareupdate="fwupdmgr update"
alias remove="rpm-ostree remove"
alias sysremove="rpm-ostree override remove"
alias flatrm="flatpak remove --delete-data"
alias rpmfind="rpm -qa | grep"
alias rpmq="distrobox enter Fedora -- dnf search"

alias untar='tar -xvf'
alias "pin-this"="ostree admin pin 0"
alias "ostree-kernel-arg"="rpm-ostree update kargs --editor"
alias q="exit"
alias c="clear"

 # Mkdir Create Parent Directories
alias mkdir='mkdir -v'

 # List (ls)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CFl'

### NETWORKING
alias myip='curl ifconfig.co'
alias netlisten='netstat -plntu'
alias pingtest='ping -c 2 wikipedia.org'
alias httpcode="curl --head --silent --output /dev/null --write-out '%{http_code}' "


# Apps
alias vlc="flatpak run org.videolan.VLC"
alias signal="flatpak run org.signal.Signal"
alias gimp="flatpak run org.gimp.GIMP"
alias simplescan="flatpak run org.gnome.SimpleScan"
alias element="flatpak run im.riot.Riot"
alias torbrowser="flatpak run com.github.micahflee.torbrowser-launcher"
alias code="flatpak run com.vscodium.codium"

alias conf="kwrite ~/.bashrc"

EOF

echo "install some Native packages"
rpm-ostree install cheat lm_sensors ksysguard tlp cargo && reboot

#also nice: waydroid fish kate gocryptfs powertop bat qemu+qemu-kvm+virt-manager

# Example local RPM: rpm-ostree install "/home/user/Downloads/MullvadVPN.rpm" && reboot
```

### Update firmware

```
fwupdmgr update #update firmware
```