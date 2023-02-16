# Linux TV using Plasma Bigscreen and Fedora Kinoite?


This is an experiment on creating the perfect TV operating system. It includes a few hacks

**No Guarantee that everything works! It is based off unofficial COPR repositories and may break in the future. It probably works very well though**

## 1. Preparation
You may want to use an ARM single-board computer from [Pine64](https://pine64.com/), [Hardkernel (ODroid)](https://www.hardkernel.com/), [OrangePi](https://orangepi.com/) or the known but expensive [RaspberryPi](https://www.raspberrypi.com/) for that.

[Download Fedora Kinoite](https://kinoite.fedoraproject.org/download/) and flash the image to a USB-Stick. A good tool for that, working on every Operating System is [Balena Etcher](https://github.com/balena-io/etcher/releases/latest).

I would recommend against LUKS encryption, when using a real TV remote control, which this Desktop is for right?

Also enable automatic logging-in if this is already an option when this is already an option, and don't create a root account but only a user.

## 2. Install the script

Just log in, open the Terminal (Ctrl+Alt+T or search for "Konsole") and paste this command:

```
wget FOLLOWING
chmod +x FOLLOWING
sh ./FOLLOWING
```

---

### Explanation of steps
I want to base this TV operating system on an atomic immutable and self-updating OSTree system for best stability. This doesnt affect usage at all, its a TV.

Many optional changes like installed Apps and Addons are optional

- Add Flathub, remove Fedora Flatpak repo to avoid Codec issues (its a mediaplayer)
- install Flathub Firefox, Kodi, VLC, Freetube and maybe more Apps.
- add simple UserChrome.css to Firefox and a minimalist user.js against some tracking
- set a custom start page for apps like Netflix, Youtube, Torrent stuff e.g.?
- install addons: UBlock Origin, Sponsorblock, NoScript, Libredirect, [Netflix ratings](https://addons.mozilla.org/de/firefox/addon/film-scores-for-netflix), [Netflix Category Browser](https://addons.mozilla.org/de/firefox/addon/netflix-category-browser), [Netflix Fixer for Linux](https://addons.mozilla.org/de/firefox/addon/netflix-fixer-for-linux), [Netflix max Bitrate](https://addons.mozilla.org/de/firefox/addon/netflix-max-bitrate), [Netflix International](https://addons.mozilla.org/de/firefox/addon/netflix-international), [Netflix AdBlock](https://addons.mozilla.org/de/firefox/addon/netflix-adblock), ...
- import Noscript and UBlock settings?
- change KDE settings: autologin without password, ... ?
- add a login script to start bigscreen automatically
- add a login script enabling the Mycroft service permanently and then deleting itself
- add the [autoupdate script from tony walker](https://github.com/tonywalker1/silverblue-update)
- Add a nice script to re-enable the "copr add" command
- warn the user that apps are now installed and it takes some time
- Add the COPRs for [Plasma Bigscreen](https://copr.fedorainfracloud.org/coprs/darrencocco/plasma-bigscreen/) and [Mycroft](https://copr.fedorainfracloud.org/coprs/lyessaadi/mycroft/)
- Install Plasma bigscreen and mycroft through rpm-ostree, last command
- notify that now a reboot is needed

([image source](https://www.muylinux.com/wp-content/uploads/2020/03/PlasmaBigScreen.jpg))
