# Guide: Captive Portals on Linux

## Explanation

A Captive Portal is the website you see when logging in on a public Wi-Fi.

```
Welcome to our Wifi-Customer-Experience-Allround service!

Accept that we save all your connections* and sell your data, and you are free 
to go!

[ ]

*we will give everything to law enforcement if they politely ask.
```

These sites redirect any HTTP request to their internally hosted website. This
has a lot of flaws, but it’s what we need to use.

## Requirements

Captive Portals only work if your DNS is insecure, and your VPN is disconnected.

So:

- `systemd-resolve`: Disable DNSSec and maybe even custom DNS servers in
`systemd-resolve`. You need to use the DNS advertised by DHCP.
- If you use any other tools, disable security features there too.
- If you use a VPN, you need to temporarily disable it. You must allow
connections without it.
- You need to open an HTTP domain. If your browser upgrades it to HTTPS by
default, this may be tricky.

**WARNING:** Do **not** change any default config files, such as
`resolved.conf`! Use an override config file as explained.

## Captive Portal Appstarter

*(Optimized for KDE and Firefox.)*

Run this:

```sh
firefox -p
```

A dialog opens. Create a new profile named **CAPTIVE** and configure it as
securely as you want.

*(You can also use your default profile, but that may block captive portals for
a good reason.)*

Create the app starter:

```sh
cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=firefox -p CAPTIVE http://captive.kuketz.de
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

If you want to use your normal profile:

```sh
cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=firefox http://captive.kuketz.de
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

*(Replace `firefox` with `flatpak run org.mozilla.firefox` if you use the
Flatpak. Replace it with the location of the binary if you use a different
installation method.)*

## VPN

A good approach is to temporarily disable the VPN, open the captive portal
page, accept their terms, and then re-enable the VPN.

Otherwise, you need to disable it manually.

Example for Mullvad (replacement app starter):

```sh
mkdir -p ~/.bin

cat > ~/.bin/mullvad-captive <<EOF
#!/bin/sh
mullvad disconnect
notify-send -a "Captive Portal" "VPN Paused" "Sign into the captive portal, 
your VPN will be enabled when you close the window again"
firefox --new-window http://captive.kuketz.de
wait $!
mullvad connect &&\
notify-send -a "Captive Portal" "VPN Enabled"
EOF

chmod +x ~/.bin/mullvad-captive

cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=~/.bin/mullvad-captive
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

Using your normal browser profile (opening a new window):

```sh
mkdir -p ~/.bin

cat > ~/.bin/mullvad-captive <<EOF
#!/bin/sh
mullvad disconnect
notify-send -a "Captive Portal" "VPN Paused" "Sign into the captive portal, 
your VPN will be enabled when you close the window again"
firefox -p CAPTIVE http://captive.kuketz.de
wait $!
mullvad connect &&\
notify-send -a "Captive Portal" "VPN Enabled"
EOF

chmod +x ~/.bin/mullvad-captive

cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=~/.bin/mullvad-captive
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

**Not-so-fun-fact**: On Android, captive portals work even with VPN enabled
because the Chromium dialog **"Captive-Portal-Chooser"** (and any other system
app) can bypass the "always on, block other connections" VPN. This is a privacy
risk.

## `systemd-resolve` settings

For additional security, the VPN app has its own DNS (which is good), so you
can block most domains when the VPN is not enabled.

Captive portals are sites within the LAN of the connected network. You do not
need DNS for these.

All addresses you need to resolve are the ones for captive portal detection
(e.g., an HTTP site that redirects you).

Run:

```sh
sudo -i
```

Currently, this does not work as expected, as DNS still gets resolved:

```sh
mkdir -p /etc/systemd/resolved.conf.d
cp /etc/systemd/resolved.conf 
/etc/systemd/resolved.conf.d/block-dns-without-vpn.conf

cat >> /etc/systemd/resolved.conf.d/block-dns-without-vpn.conf <<EOF
#
# BLOCK INTERNET WITHOUT VPN
#
# Disable DNS by placing an incorrect value
DNS=#

# Whitelist captive portal websites
Domains=~captive.kuketz.de ~captive.open-mind-culture.org ~httpforever.com 
~connectivitycheck.grapheneos.network/generate_204 
~grapheneos.online/generate_204
EOF

systemctl restart systemd-resolved
```

Even with Mullvad turned off (no blocking), it can resolve domains.

An alternative would be to whitelist the browser profile as an app ("Split
Tunneling") to connect without the VPN. While this works well on Android, it
crashes my client on Linux.

```
