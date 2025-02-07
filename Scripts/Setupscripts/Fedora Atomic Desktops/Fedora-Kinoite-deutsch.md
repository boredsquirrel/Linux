# Fedora Kinoite Einrichtung
Fedora Kinoite ist eine sehr einfache, moderne und freundliche Distribution.

Durch das uBlue Projekt kann man auch hier alle nötigen Treiber, Mediacodecs
und mehr bekommen.

## Installieren

Download von [Fedoras
Website](https://fedoraproject.org/atomic-desktops/kinoite/) , auf einen
USB-Stick brennen mit dem [Fedora Media
Writer](https://flathub.org/apps/org.fedoraproject.MediaWriter) von Flathub
oder derselben Website. Ventoy funktioniert nicht zuverlässig.

Wichtig bei der Einrichtung:

- Keinen root Account erstellen
- Festplatte mit LUKS verschlüsseln
- Sichere Passwörter verwenden (hauptsächlich für die
Festplattenverschlüsselung)
- Unter "Netzwerk" kann man den Hostname des PCs zu "PC" umbenennen, was ihn
unauffällig in lokalen Netzwerken macht


# Nach der Installation

Möchte man mehr Pakete vorinstalliert haben, die einem das Leben erleichtern,
kann man zu Kinoite von [uBlue](https://universal-blue.org) wechseln.

normal:
```bash
rpm-ostree rebase --reboot
ostree-unverified-registry:ghcr.io/ublue-os/kinoite-main:latest

# nach dem neutart, wichtig
rpm-ostree rebase --reboot
ostree-image-signed:docker://ghcr.io/ublue-os/kinoite-main:latest
```bash

Für NVIDIA, Framework, Asus, Surface und andere Varianten, [ein Abbild aus
dieser Liste wählen](https://github.com/orgs/ublue-os/packages).

Für das "uBlue Gesamtpaket" kann man [Aurora](getaurora.dev) oder
[Bluefin](projectbluefin.io) nehmen.

### Nach dem Neustart

Terminal öffnen, das hier einfügen

```bash
cat <<EOF







==========================================

Fedora Kinoite Einrichtung

Ein paar Tricks, um die Nutzung zu vereinfachen!

===========================================


EOF

echo "Fedora Flaptak repository mit Flathub tauschen"
flatpak remote-add --if-not-exists flathub
https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete fedora -y

cat <<EOF
# Mehr Flatpak repositories
github.com/boredsquirrel/flatpak-remotes

# Empfohlene Flatpak-Apps
github.com/boredsquirrel/recommended-flatpak-apps

# Alias deiner Flatpaks zum einfachen Öffnen
github.com/boredsquirrel/flatalias

# Löschen ungenutzter Daten alter Flatpak apps
github.com/boredsquirrel/flatpak-trash-remover

# COPR Repositories einfach hinzufügen
github.com/boredsquirrel/copr-command

EOF

xdg-open github.com/boredsquirrel/flatpak-remotes
xdg-open github.com/boredsquirrel/recommended-flatpak-apps
xdg-open github.com/boredsquirrel/flatalias
xdg-open github.com/boredsquirrel/flatpak-trash-remover
xdg-open github.com/boredsquirrel/copr-command

echo "Discover Quellen aktualisieren"
pkcon refresh

echo "Baloo deaktivieren (verursacht Probleme mit ostree)"
balooctl disable && balooctl purge

echo "Geoclue Location Service deaktivieren"
systemctl disable geoclue
touch ~/.local/share/applications/geoclue-demo-agent.desktop

echo "DiscoverNotifier deaktivieren"
touch ~/.local/share/applications/org.kde.discover.notifier.desktop

echo "Ein paar gute Bash-Aliasse hinzufügen"
cat >> ~/.bashrc <<EOF



# Some nice Bash shortcuts for easy usage

alias logout="qdbus org.kde.ksmserver /KSMServer logout 0 0 1"
alias update='flatpak update -y && notify-send -a "Updates" "Flatpaks updated"
; distrobox upgrade --all ; rpm-ostree update'
alias upfin='update && shutdown -h now'
alias rstat="rpm-ostree status"
alias fwup="fwupdmgr update"
alias flatrm="flatpak remove --delete-data"
alias rpmfind="rpm -qa | grep"

alias untar='tar -xvf'
alias "pin-this"="ostree admin pin 0"
alias q="exit"
alias c="clear"

# Mkdir Create Parent Directories
alias mkdir='mkdir -v'

# List (ls)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CFl'

# NETWORKING
alias myip='curl ifconfig.co'
alias netlisten='netstat -plntu'
alias pingtest='ping -c 2 wikipedia.org'
alias httpcode="curl --head --silent --output /dev/null --write-out
'%{http_code}' "

alias conf="kwrite ~/.bashrc"

EOF
```bash

### Einige empfohlene Apps zum Layern

distrobox ist bereits installiert

Grundlegende Shell Apps
- `fish` ist eine einfachere Shell mit Auto-Vervollständigung und mehr
- `helix` (vim in rust)
- `bat eza glow` und weitere coreutil Ersatze in Rust, die nicht 1:1 kompatibel

sind

Virtualisierung
- [Siehe
Forumpost](https://discussion.fedoraproject.org/t/minimal-virt-manager-install/1

19709/4), ersetze "dnf" mit "rpm-ostree"
- andere Architekturen finden mit `rpm-ostree search qemu-system`

### Firmware updaten

```bash
fwupdmgr update
```bash
