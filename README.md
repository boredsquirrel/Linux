# - - - - - - - - Linux-Help - - - - - - - - 
Some little things that make Linux distros easier to use!

I use KDE and tried different Distributions, at the moment staying with Fedora Kinoite. Many things are different here.

## 1. [Creating a safe profile](https://github.com/trytomakeyouprivate/Linux-help/blob/main/secure-second-profile.md)

## 2. [Appstarters](https://github.com/trytomakeyouprivate/Linux-help/Appstarters/)


## 3. Setup-Scripts
Setting up a Linux Distribution is more work than just installing the System. You will have to install and uninstall a lot of apps, and set some settings.
[Here is a cool example of creating a minimal Fedora KDE Operating System, without anything not wanted installed](https://www.reddit.com/r/Fedora/comments/9a0i93/howto_minimal_kde_install_on_fedora/)

I have created my own scripts for
- [Fedora Kinoite](https://github.com/trytomakeyouprivate/Fedora-OSTree-Setup) (super stable containerized Distro, the future)
- easy Linux Mint setup for low-end computers
- Kubuntu/KDE Neon

The scripts include:

1. Uninstalling unwanted apps
2. Adding the Flatpak repository Flathub
3. Optional: adding Snap repo
4. Installing basic apps (some are better replacements of previously uninstalled apps!)
5. Get external apps (.deb or .rpm respectively) and download them (check integrity yourself! I have no automatic checks yet)
6. Set some settings like systemd timers
7. Downloading useful appstarters
8. Lynis security audit
9. Waydroid install
10. ...
