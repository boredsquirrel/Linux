#!/bin/bash
echo """
#####################                                         #####################
#####################                                         #####################
#####################       FEDORA KIONITE SETUP SCRIPT       #####################
#####################                                         #####################
#####################                                         #####################

Execute the scripts:
- Download
- Open the Terminal in its folder (cd PATH/TO/FOLDER or right-click in Dolphin)
- do "sudo chmod +x Fedora-Kionite-setupscript-part1.sh Fedora-Kionite-setupscript-part2.sh"
- do "sudo sh Fedora-Kionite-setupscript-part1.sh"


This script sets up all you really need to enjoy the unbreakable,
stable and secure experience of Fedora Kionite.

In the end you have to reboot, to apply changes when installing RPMs. Configure Waydroid in the second script.

1. removing unwanted apps
    - this has to be activated manually, as changing the tree have negative effects
    - Gwenview, replaced with XNView
    - Kmousetool
    - KMag
    - maybe the RPM Firefox if you choose so


2. Setting up Flatpak repositories (where you get your apps from)
    - Flathub
    - Fedora
    - KDE
    - GNOME Nightly if you activate that


3.  installing Flatpaks
    - you have to edit this script, remove the "#" to install the packages


4. Installing Snap Package manager
    - you have to manually activate that
    - allowing /home to be used through /var/home, this removes the containerization of Kionite in a way!


5. Configuring settings
    - enabling automatic rpm-ostree updates (you still need to reboot)
    - Automatic Flatpak updates via cron.daily (every day)
    - enabling Mac-Adress randomization for privacy
    - enabling TLP as systemd module for Battery saving
    - setting up a nice GRUB theme
    - applying UEFI Firmware updates


6. Downloading Microsoft Fonts for compatibility (Times, Arial, Cambria,...)


7. Downloading Lynis and making a security audit


8. Setting up RPMfusion repositories
    - deactivated by default, as you should install as little as possible
    - This includes the RPMFusion "free" and "nonfree" variant
    - a special RPMfusion repo is needed to play DVDs (VLC has that package included, other Flatpaks don't)

    - Added Repositories slow down rpm-ostree updates even more!
    

9. Installing RPM Packages
    - A lot is deactivated, try to get along without it, then use it
    - RPMs needed to deal with Windows stuff
    - RPMs not yet available as Flatpaks


10. Installing the Android Emulator Waydroid
    - Adding the aleasto/waydroid repo
    
Part 2:
    - Downloading Android
    - configuring free form windows to use Android apps normally
    - NOT YET: configuring keyboard layout
    - not added: downloading and installing Android apps per ADB



Find Tips here: https://fedoramagazine.org/how-i-customize-fedora-silverblue-and-fedora-kinoite/

"""

echo """
#################################################################

1. Removing some unwanted Apps
"""

# sudo rpm-ostree override remove gwenview kmag kmouse*

echo """
#################################################################
Adding flathub repo, click "Install" when Discover opens
"""

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

wget https://flathub.org/repo/flathub.flatpakrepo
xdg-open ~/flathub.flatpakrepo
wait 30
rm ~/flathub.flatpakrepo


echo """
#################################################################
Adding Fedora and KDE Flatpak repos
"""

flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org

flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo

#flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

flatpak update --appstream && flatpak update


echo """
#################################################################
Installing Flatpak apps
"""

flatpak install -y flathub com.github.tchx84.Flatseal;
flatpak install -y flathub com.xnview.XnViewMP;
flatpak install -y flatub org.keepassxc.KeePassXC

#sudo rpm-ostree override remove -y org.mozilla.firefox && exit && flatpak install flathub org.mozilla.firefox

#flatpak install -y flathub org.freefilesync.FreeFileSync;
#flatpak instal -y flathub com.github.zocker_160.SyncThingy
#flatpak install -y org.gnome.simplescan
#flatpak install -y org.kde.kate

# Messaging
#flatpak install -y flathub org.signal.Signal;
#flatpak install -y flathub org.telegram.desktop
#flatpak install -y flathub im.riot.Riot
#flatpak install -y flathub eu.betterbird.Betterbird

# Internet
#flatpak install -y flathub website.i2pd.i2pd;
#flatpak install -y flathub org.onionshare.OnionShare
#flatpak install -y flathub com.github.micahflee.torbrowser-launcher
#flatpak install -y flathub org.qbittorrent.qBittorrent
# flatpak install -y flathub com.github.gabutakut.gabutdm

# Media
#flatpak install -y flathub org.videolan.VLC
#flatpak install -y flathub bimp;
#flatpak install -y flathub dev.alextren.Spot;
#flatpak install -y flathub io.freetubeapp.FreeTube;
#flatpak install -y app.rafaelmardojai.Blanket;
#flatpak install -y flathub com.spotify.Client;
#flatpak install -y flathub com.github.wwmm.easyeffects
#flatpak install -y flathub com.xnview.XnConvert
#flatpak install -y flathub org.gimp.GIMP

#flatpak install -y flathub fr.handbrake.ghb fr.handbrake.ghb.Plugin.IntelMediaSDK
#flatpak install -y flathub com.obsproject.Studio
#flatpak install -y flathub com.obsproject.Studio.Plugin.OBSVkCapture #and other plugins


# Crypto
#flatpak install -y flathub monero-gui;
#flatpak install -y flathub org.cryptomator.Cryptomator;


echo "removing unused Flatpak Libraries (probably none)"
flatpak uninstall -y --unused


echo """
#################################################################
Adding the Snapd app for installing Snaps

see: https://snapcraft.io/docs/home-outside-home
"""

#sudo mkdir -p /home/$USER
#sudo mount --bind /var/home/$USER /home/$USER

#echo "installing Snapd..."
#sudo rpm-ostree install snapd
#sudo snap update

# Repo to discover?

# ---------- Different method ------------
echo """
Or install it through Toolbox (less security impact but requires more resources)
"""

# toolbox create -y snap && toolbox enter snap && sudo dnf install -y snapd

echo """
##########################
find Snaps using snap find
install snaps using snap install
"""


echo """
#################################################################
Configuring Settings

Auto-updates: https://barnix.io/how-to-enable-automatic-update-staging-in-fedora-silverblue/
"""

# --- rpm-ostree automatic
sudo sed -i 's/none/stage/g' /etc/rpm-ostreed.conf  #set to install if set to none
sudo sed -i 's/check/stage/g' /etc/rpm-ostreed.conf #set to install if set to check

rpm-ostree reload

systemctl enable rpm-ostreed-automatic.timer --now


# ---- Flatpaks

sudo printf "#!/bin/sh\n/usr/bin/flatpak -y update 2>&1 >> ~/cron/cron-flatpak.log" > /etc/cron.hourly/flatpak-update.sh
sudo chmod +x /etc/cron.hourly/flatpak-update.sh

# ---- mac adresses

echo "enabling mac adress randomization for privacy"
sudo printf "[device-mac-randomization]\nwifi.scan-rand-mac-address=yes\n[connection-mac-randomization]\nethernet.cloned\nmac-address=random\nwifi.cloned-mac-address=random" > /etc/NetworkManager/conf.d/99-custom.conf

# --- tlp

echo "enabling TLP for saving battery"
sudo systemctl enable --now tlp


echo """#################################################################

Updating the firmware, if an update is available
"""
sudo fwupdmgr refresh; sudo fwupdmgr get-updates; sudo fwupdmgr update


# Grub-Theme
echo "Installing a fancy GRUB bootloader theme"
wget https://github.com/vinceliuice/grub2-themes.git
unzip grub2-themes*.zip
rm grub2-themes*.zip
cd ~/grub2-themes-master/
sudo chmod +x install.sh
sudo sh install.sh -t vimix -b

echo """
#################################################################
Searching for a Download manager for multithreaded Downloads?
"""

firefox https://addons.mozilla.org/en-US/firefox/addon/multithreaded-download-manager/

echo """
#################################################################
Installing Microsoft Fonts to ~/.local/share/fonts/mscorefonts
"""

mkdir -p ~/.local/share/fonts/mscorefonts

wget https://cloud.uol.de/s/6HtRPcJZeMip7aC -P ~/

cd ~/
unzip ms-corefonts.zip
rm ms-corefonts.zip

cp -v ms-corefonts/*.ttf ms-corefonts/*.TTF ~/.local/share/fonts/mscorefonts/

#echo "Enabling System wide, currently no Flatpak support:"
#sudo mkdir -p /usr/local/share/fonts/mscorefonts/
#sudo cp -v fonts/*.ttf fonts/*.TTF /usr/local/share/fonts/mscorefonts/


echo """#################################################################
Running Lynis for security auditing

https://github.com/CISOfy/lynis

"""

git clone https://github.com/CISOfy/lynis && sudo ~/lynis/lynis audit system


# echo """
#################################################################
Adding RPMfusion repos, please uncomment what you need

"rpmfusion-free-release-tainted" is needed for playing DVDs if the flatpak app requests it
"""

#sudo rpm-ostree --install rpmfusion-free-release-tainted #--install rpmfusion-free-release #--install rpmfusion-nonfree-release

#echo """
#################################################################
adding the BTFS COPR repository
"""
# sudo wget https://copr.fedorainfracloud.org/coprs/elxreno/btfs/repo/fedora-37/elxreno-btfs-fedora-37.repo -P /etc/yum.repos.d/

echo """
#################################################################

If you want to add a COPR repository, download its ".repo" file or do the ostree command:

sudo wget URL-TO-.repo-FILE -P /etc/yum.repos.d

sudo ostree remote add <name-of-repo> <repository-url>
"""



echo """
#################################################################

Installing RPMs to layer over the Fedora base. Use layered RPMs as little as possible.


    If you just need a specific app not integrated into the system, try toolbox:

    toolbox create
    toolbox enter
    sudo dnf install APPNAME

#################################################################
"""

#echo """RPMs for Intel hardware video acceleration:"""

# rpm-ostree install intel-gpu-tools libva-intel-driver libva-intel-hybrid-driver libva-utils libva-vdpau-driver libvdpau-va-gl mpv vdpauinfo

#echo """Installing Media Codecs, for apps not integrating them
"""

#sudo rpm-ostree install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
#sudo rpm-ostree install -y lame\* --exclude=lame-devel
#rpm-ostree group upgrade --with-optional Multimedia


echo """
#################################################################

Installing some needed RPMs:

Antivirus, Brute-Force Blocker, Battery-saver, Bittorrent filesystem, System cleaner, Video Thumbnails, Python installer
"""

#sudo rpm-ostree override remove libavcodec-free --install clamtk* fail2ban tlp unrar stacer ffmpegthumbs pip #btfs

# already there: ntfs-3g, wget, udftools

#sudo rpm-ostree install -y needrestart preload #only needed for RPMs ?
#sudo rpm-ostree install -y smem
#sudo rpm-ostree install -y libdvdcss* # maybe not needed, VLC Flatpak has it integrated, Handbrake doesnt

# sudo rpm-ostree install -y btrbk ctags edk2-ovmf exfat-utils fuse-exfat fzf kitty net-snmp postfix syncthing tmux-powerline waypipe zsh fish flatpak-builder kernel-tools power-profiles-daemon pulseaudio-utils systemd-container ffmpeg-libs


########### windows stuff: ############

# echo """
#################################################################

If you deal with Windows, these RPMs are useful, installing...

"""

#sudo rpm-ostree install -y woeusb* exfat-utils fuse-exfat


echo """
#################################################################

Installing Waydroid from the aleasto/waydroid COPR repository

(Currently there is no Flatpak for Waydroid, so it will be installed as overlay)

Using the Freeform Windows, you can start Waydroid Apps directly from your App menu!
"""

# other way, not sure if works
#sudo ostree remote add aleasto-waydroid-fedora-37.repo https://copr.fedorainfracloud.org/coprs/aleasto/waydroid/repo/fedora-37/aleasto-waydroid-fedora-37.repo

sudo wget https://copr.fedorainfracloud.org/coprs/aleasto/waydroid/repo/fedora-37/aleasto-waydroid-fedora-37.repo -P /etc/yum.repos.d/
sudo rpm-ostree install -y waydroid

systemctl reboot
