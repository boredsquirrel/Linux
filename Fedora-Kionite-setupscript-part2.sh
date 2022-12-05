#!/usr/bin/env sh

echo "Installing and setting up Waydroid"

# 1. Install waydroid
sudo waydroid init -c https://ota.waydro.id/system -v https://ota.waydro.id/vendor
sudo waydroid container start
waydroid session start
waydroid show-full-ui

# 2. Allow freeform windows
waydroid prop set persist.waydroid.multi_windows true


# 3. Create shared folders

sudo mount --bind ~/Downloads ~/.local/share/waydroid/data/media/0/Download
sudo mkdir ~/.local/share/waydroid/data/media/0/Files
mkdir ~/Waydroid-Shared
sudo mount --bind ~/Waydroid-Shared ~/.local/share/waydroid/data/media/0/Files

# 4. optional: change keyboard language

# 4.1 allow writing permissions

sudo mount -o remount,rw /var/lib/

chmod 660 /var/lib/waydroid/rootfs/system/usr/keylayout/Generic.kl

#chmod 440 /var/lib/waydroid/rootfs/system/usr/keylayout/Generic.kl

sudo mount -o remount /var/lib/

# 5.2 change the .kl file
# You may change the QWERY layout to what you want. Editing the install script to fit your needs wont be hard.

sudo nano /var/lib/waydroid/rootfs/system/usr/keylayout/Generic.kl

# 6. Enable Clipboard
pip3 install pyclip

# 7. Enable App-install appstarter
printf """[Desktop Entry]\nComment=\nExec=waydroid app install\nGenericName=Installs Apps to the Waydroid container\nIcon=install\nName=Waydroid install\nNoDisplay=false\nPath=\nStartupNotify=true\nTerminal=false\nTerminalOptions=\nType=Application\nX-KDE-SubstituteUID=false\nX-KDE-Username=""" > ~/.local/share/applications/waydroid-install.desktop

