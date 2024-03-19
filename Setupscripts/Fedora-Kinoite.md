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

Switch to Fedora Kinoite from [uBlue](https://universal-blue.org): 

normal:
```
rpm-ostree rebase --reboot ostree-unverified-registry:ghcr.io/ublue-os/kinoite-main:($rpm -E %fedora)

# after reboot, important
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/kinoite-main:($rpm -E %fedora)
```

For nVIDIA, Framework, Asus, Surface and other variants, [see their image list](https://github.com/orgs/ublue-os/packages).

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
github.com/trytomakeyouprivate/flatpak-remotes

# Recommended Flatpak apps
github.com/trytomakeyouprivate/recommended-flatpak-apps

echo "Alias your flatpak apps for cli usage"
github.com/trytomakeyouprivate/flatalias

echo "Cleanup unused flatpak data"
github.com/trytomakeyouprivate/flatpak-trash-remover

echo "Add COPR repos easily"
github.com/trytomakeyouprivate/copr-command

EOF

xdg-open github.com/trytomakeyouprivate/flatpak-remotes
xdg-open github.com/trytomakeyouprivate/recommended-flatpak-apps
xdg-open github.com/trytomakeyouprivate/flatalias
xdg-open github.com/trytomakeyouprivate/flatpak-trash-remover
xdg-open github.com/trytomakeyouprivate/copr-command

echo "refresh Disvover sources"
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

distrobox is already installed

Basic shell stuff
- `fish`
- `[rust coreutils](https://github.com/uutils/coreutils) ([good COPR](https://copr.fedorainfracloud.org/coprs/salimma/rust-coreutils))`
- `helix` (vim in rust)
- `bat eza glow` and more better replacements for coreutils that dont try to be 1:1 compatible

Virtualization
- `virt-manager qemu qemu-kvm`
- find different architectures with `rpm-ostree search qemu-system`

### Update firmware

```
fwupdmgr update
```
