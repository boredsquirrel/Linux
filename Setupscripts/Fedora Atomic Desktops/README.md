# Fedora Kinoite Setup

Kinoite is a really nice Distro. KDE-desktop, immutable, up-to-date Fedora packages.

Using UBlue you get autoupdates, restricted Codecs and drivers and even an NVidia version.

## Install

Download from [kinoite.fedoraproject.org](kinoite.fedoraproject.org) , burn with [Balena Etcher](https://etcher.balena.io/#download-etcher) or [Fedora Media Writer](https://flathub.org/apps/org.fedoraproject.MediaWriter). Ventoy doesnt work as far as I have tested.

important:

- Don't create a root account
- Encrypt your Disk using LUKS
- Use strong passwords
- Under "Network", name your host "PC" to avoid being fingerprinted in local networks


# Post Installation

If you want an easier experience with less packages to layer, switch to Fedora Kinoite from [uBlue](https://universal-blue.org): 

normal:
```
rpm-ostree rebase --reboot ostree-unverified-registry:ghcr.io/ublue-os/kinoite-main:latest

# after reboot, important
rpm-ostree rebase --reboot ostree-image-signed:docker://ghcr.io/ublue-os/kinoite-main:latest
```

For NVIDIA, Framework, Asus, Surface and other variants, [see their image list](https://github.com/orgs/ublue-os/packages).

For the "full uBlue experience", use [Aurora](getaurora.dev) or [Bluefin](projectbluefin.io).

### after reboot

```
cat <<EOF







==========================================

Fedora Kinoite Setup help

These are some little things improving the
experience of this awesome distro!

===========================================


EOF

echo "replace Fedora Flatpak with Flathub"
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete fedora -y

cat <<EOF
# More Flatpak repos
github.com/boredsquirrel/flatpak-remotes

# Recommended Flatpak apps
github.com/boredsquirrel/recommended-flatpak-apps

# Alias your flatpak apps for cli usage
github.com/boredsquirrel/flatalias

# Cleanup unused flatpak data
github.com/boredsquirrel/flatpak-trash-remover

# Add COPR repos easily
github.com/boredsquirrel/copr-command

EOF

xdg-open github.com/boredsquirrel/flatpak-remotes
xdg-open github.com/boredsquirrel/recommended-flatpak-apps
xdg-open github.com/boredsquirrel/flatalias
xdg-open github.com/boredsquirrel/flatpak-trash-remover
xdg-open github.com/boredsquirrel/copr-command

echo "refresh Discover sources"
pkcon refresh

echo "Deactivate Baloo (may cause problems on ostree systems)"
balooctl disable && balooctl purge

echo "disable Geoclue location service"
systemctl disable geoclue
touch ~/.local/share/applications/geoclue-demo-agent.desktop

echo "Disable DiscoverNotifier"
touch ~/.local/share/applications/org.kde.discover.notifier.desktop

echo "Adding some nice shortcuts"
cat >> ~/.bashrc <<EOF



# Some nice Bash shortcuts for easy usage

alias logout="qdbus org.kde.ksmserver /KSMServer logout 0 0 1"
alias update='flatpak update -y && notify-send -a "Updates" "Flatpaks updated" ; distrobox upgrade --all ; rpm-ostree update'
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
alias httpcode="curl --head --silent --output /dev/null --write-out '%{http_code}' "

alias conf="kwrite ~/.bashrc"

EOF
```

### Some recommended Apps to layer

distrobox is already installed (on uBlue)

Basic shell stuff
- `fish` is friendly shell with autocompletion and more
- `helix` (vim in rust)
- `bat eza glow` and more better replacements for coreutils that dont try to be 1:1 compatible

Virtualization
- [See this forum post for instructions for a minimal Virt-manager install](https://discussion.fedoraproject.org/t/minimal-virt-manager-install/119709/4). Replace "dnf" with "rpm-ostree"
- find different architectures with `rpm-ostree search qemu-system`

### Update firmware

```
fwupdmgr update
```
