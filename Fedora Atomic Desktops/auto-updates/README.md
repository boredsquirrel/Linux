## Automatic system updates, done right

Fedora Atomic Desktops are currently not completely usable, as they follow the 
same unelegant path as "traditional" distributions, where users need to consent 

in doing updates.

This means that you cannot install these Distributions on "your grandmas PC", 
because she will never click on that tray icon and simply forget it.

Instead of relying on the user to determine when an update is wanted, this 
should be done logically and automated.

This, in addition to removing the GUI software store integrations, can lead to 
possible speed improvements too.

The native integrations of rpm-ostree, flatpak, distrobox and fwupdmgr avoid 
using packagekit, and thus sync issues and additional overhead.

> [!NOTE]
> Also take a look at [ublue-update](https://github.com/ublue-os/ublue-update), 

a project doing something very similar, but in a more generalistic way, using 
[topgrade](https://github.com/topgrade-rs/topgrade).
> They seem to struggle with maintenance, and I prefer a more minimal approach 
to keep it simple.

### 1. A script checking for the conditions
*see the script `auto-updates` in the setup script*

Conditions:
- Device must be charging (optional)
- Device must have over x% charge (default 40)
- Active network must not be "metered"

> [!WARNING]
> It is important to manually set metered networks as so, as Networkmanager has 

no way of differentiating phone hotspots, USB-tethering over a phone or other 
indirectly metered connections from regular Wifis.
>
> Note also that KDE Plasma seems to not be able to differentiate a LAN 
connection from a USB-tethered phone hotspot.

*(This is way easier on Android/phones, where one can assume that cell data is 
limited and the device uses a different antenna for it, and Wifi is mostly 
unmetered.)*

### 2. A simple systemd service running a script
*See the `auto-updates.service` in the setup script*

### 3. A timer repeating that service daily
*See the `auto-updates.timer` in the script*

### 4. Change some parameters
In the script:
- enable AC requirement
- change ran commands
- uncomment fwupdmgr updates

In the service:
- change run conditions

In the timer:
- change interval

### 5. Start the service

```bash
sudo systemctl enable --now auto-updates.timer
```bash

### 6. Debloat
You may want to remove the redundant GUI store integration. It works well but 
is not needed.

```bash
# Silverblue / Workstation Atomic / GNOME Atomic
rpm-ostree override remove gnome-software-rpm-ostree

# Kinoite / KDE Atomic
rpm-ostree override remove plasma-discover-rpm-ostree plasma-discover-notifier
```bash

### Note
Fedora wants to implement automatic updates in future releases, as does ublue 
by default. If this service is not upstreamed, disable those services to avoid 
high data usage or other unwanted behaviors.

### ToDo
- [x] custom non-daily interval (in the timer)
- [x] automatic flatpak updates (in the script)
- [x] automatic `distrobox upgrade --all` (in the script)
- [ ] interactive message using zenity or kdialog
  - [ ] interactive reboot button
  - [ ] distro upgrade button: warn when distro version is EOL, add an upgrade 
button
- [ ] list updated apps in message
- [ ] info popups
  - [ ] warn on security critical updates (Secadvisories)
  - [ ] warn on firmware updates (workaround for unpredictable fwupdmgr 
behavior)
- [ ] rewrite in Rust
