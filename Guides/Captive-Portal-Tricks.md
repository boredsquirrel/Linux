# Guide: Captive Portals on Linux

Explanation:

A Captive Portal is the website you see when logging in on a public Wifi.

```
Welcome to our Wifi-Customer-Experience-Allround service!

Accept that we save all your connections* and sell your data, and you are free to go!

[ ]

*we will give everything to law enforcement if they politely ask.
```

These sites redirect any HTTP request to their internally hosted Website. This has a lot of flaws, but its what we need to use.

## Requirements

Captive Portals are shit. They only really work if your DNS is insecure, and you have your VPN disconnected.

So:
- `systemd-resolve`: Disable DNSSec and maybe even custom DNS servers in systemd-resolve. You need to use the DNS advertised by DHCP.
- If you use any other tools, disable security features there too
- If you use a VPN, you need to temporarily disable it. You have to allow Connections without it.
- You need to open a http Domain, if your browser upgrades it to https by default, this may be tricky

***WARNING: Dont change any default config files, for example `resolved.conf`! Use an override config file as explained.***

## Captive Portal Appstarter
(This is optimized for KDE and uses Firefox.)


Run this:

```
firefox -p
```

A dialog opens. Create a new Profile named "CAPTIVE", make it normally secure as you want.

(You can also use your default profile, but that may block Captive portals for a good reason)

Create the Appstarter:

```
cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=firefox -p CAPTIVE http://captive.kuketz.de
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

Only if you want to use your normal profile:

```
cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=firefox http://captive.kuketz.de
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

(replace `firefox` with `flatpak run org.mozilla.firefox` if you use the Flatpak. Replace it with the location of the binary if you use that.)

## VPN

A fancy way would be to temporarily disable the VPN, open the Captive Portal page, accept their shitty TOS and then enable the VPN again.

Otherwise you need to disable it manually.

Example for Mullvad (replacement Appstarter):

```

mkdir ~/.bin

cat > ~/.bin/mullvad-captive <<EOF
#!/bin/sh
mullvad disconnect
notify-send -a "Captive Portal" "VPN Paused" "Sign into the Captive portal, your VPN will be enabled when you close the window again"
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

```

mkdir ~/.bin

cat > ~/.bin/mullvad-captive <<EOF
#!/bin/sh
mullvad disconnect
notify-send -a "Captive Portal" "VPN Paused" "Sign into the Captive portal, your VPN will be enabled when you close the window again"
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

**Not-so-fun-fact**: On Android Captive Portals work with enabled VPN, because the Chromium Dialog "Captive-Portal-Chooser" (and any other system app) can even bypass the "always on, block other connections" VPN. This is a privacy nightmare.

## systemd-resolve settings

Lets be even more paranoid. The VPN app has its own DNS (which is quite good), so this makes it easy for us to just block most domains if there is no VPN enabled.

Captive Portals are Sites in the LAN of the connected Network, you need no DNS for these.

All addresses you need to translate is the one captive portal address you use as HTTP-Site (that gets then transferred to the LAN Captive Site).

```
sudo -i
```

Currently not working as intended, DNS gets resolved anyways:

```
mkdir /etc/systemd/resolved.conf.d
cp /etc/systemd/resolved.conf /etc/systemd/resolved.conf.d/block-dns-without-vpn.conf
cat >> /etc/systemd/resolved.conf.d/block-dns-without-vpn.conf <<EOF
#
#
#
#   BLOCK INTERNET WITHOUT VPN
#
#
# Disable the DNS by placing an incorrect value
DNS=#
#
# Whitelist Captive Portal websites
Domains=~captive.kuketz.de ~captive.open-mind-culture.org ~httpforever.com ~connectivitycheck.grapheneos.network/generate_204 ~grapheneos.online/generate_204

EOF

systemctl restart systemd-resolved
```

Even with Mullvad turned off (no blocking) it can resolve Domains.

An alternative would be to whitelist the Browser Profile as an app ("Split Tunneling"), to connect without the VPN, but while this works great on Android, it crashes my Client on Linux.
