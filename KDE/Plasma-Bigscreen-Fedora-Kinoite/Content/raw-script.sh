#!/bin/sh

# flatpak remotes (Fedora flatpaks will miss codecs)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpam remote-delete fedora

# flatpak install
flatpak update && flatpak install -y freetube firefox amberol vlc blanket flatseal easyeffects syncthingy

# system settings

# auto updates for rpm-ostree and flatpaks
git clone https://github.com/tonywalker1/silverblue-update
sudo sh ./silverblue-update/install.sh

#------------Create firefox profile ---------
cd ~/.var/app/org.mozilla.firefox/.mozilla/firefox

# remove weird standard profiles
rm -rf *default
rm -rf *default-release

#
printf"""[Profile]
Name=TV-Firefox
IsRelative=0
Path=/var/home/user/.var/app/org.mozilla.firefox/.mozilla/firefox/TV-Firefox""" >> profiles.ini

# ---- restore COPR command ------
# yes this is a really nice hack! Thanks to https://www.reddit.com/user/telemachuszero/

printf"""#!/bin/bash
pushd /tmp

author="$(echo $2 | cut -d '/' -f1)"
reponame="$(echo $2 | cut -d '/' -f2)"

if [ ! $3 ]; then
 releasever="$(rpm -E %fedora)"
else
 releasever=$3
fi

if [[ "$1" == "enable" ]]; then
 echo "$author/$reponame -> $releasever"
 curl -fsSL https://copr.fedorainfracloud.org/coprs/$author/$reponame/repo/fedora-$releasever/$author-$reponame-fedora-.repo | sudo tee /etc/yum.repos.d/$author-$reponame.repo
elif [[ "$1" == "remove" ]]; then
 sudo rm /etc/yum.repos.d/$author-$reponame.repo
fi""" | sudo tee /var/usrlocal/bin/copr

sudo chmod +x /var/usrlocal/bin/copr

# ------- rpm-ostree -------------

sudo copr enable lyessaadi/mycroft 
sudo copr enable darrencocco/plasma-bigscreen

rpm ostree override remove firefox firefox-langpacks --install plasma-bigscreen mycroft-core

notify-send 'System setup' 'Applications added to your system. You have to reboot to complete setup.'
