# Guide: Captive Portals on Linux

## Explanation

A **Captive Portal** is the webpage you see when logging into a public Wi-Fi network.

```
Welcome to our Wifi-Customer-Experience-Allround service!

Accept that we save all your connections* and sell your data, and you are free to go!

[ ]

*We will give everything to law enforcement if they politely ask.
```

These sites intercept any **HTTP** request and redirect it to their internally hosted login page. The system has many flaws, but it’s what we have to work with.

---

## Requirements

Captive Portals are problematic. They only work if your **DNS is insecure** and your **VPN is disconnected**.

To ensure they work:

- **Disable DNSSEC** and custom DNS servers in `systemd-resolved`. You must use the **DHCP-assigned DNS**.
- **Disable security features** in any other DNS tools you use.
- **Temporarily disable your VPN** to allow connections without it.
- **Open an HTTP URL** (not HTTPS), as many browsers automatically upgrade HTTP requests to HTTPS.

**WARNING:** Do not modify default config files like `resolved.conf`! Use an **override config file** instead (explained later).

---

## Captive Portal App Starter

*(Optimized for KDE and Firefox.)*

Run:

```sh
firefox -p
```

A profile manager window opens. **Create a new profile named `CAPTIVE`** and configure it as securely as you want.

*(You can also use your default profile, but it may block Captive Portals for security reasons.)*

### Create the App Starter

```sh
cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=firefox -p CAPTIVE http://captive.kuketz.de
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

**If you want to use your normal profile instead**:

```sh
cat > ~/.local/share/applications/captiveportal.desktop <<EOF
[Desktop Entry]
Exec=firefox http://captive.kuketz.de
Icon=network-wireless-symbolic
Name=Captive Portal
Type=Application
EOF
```

**If using the Firefox Flatpak**, replace `firefox` with:

```sh
flatpak run org.mozilla.firefox
```

Or, if using a custom-installed binary, adjust the path accordingly.

---

## Handling VPN Connections

A more convenient way is to temporarily **disable the VPN**, log into the Captive Portal, then re-enable the VPN automatically.

### Example for Mullvad VPN

#### Create the VPN-Aware App Starter

```sh
mkdir -p ~/.bin

cat > ~/.bin/mullvad-captive <<EOF
#!/bin/sh
mullvad disconnect
notify-send -a "Captive Portal" "VPN Paused" "Sign into the Captive Portal. Your VPN will be re-enabled when you close the window."
firefox --new-window http://captive.kuketz.de
wait $!
mullvad connect && notify-send -a "Captive Portal" "VPN Enabled"
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

#### Using Your Normal Browser Profile

```sh
mkdir -p ~/.bin

cat > ~/.bin/mullvad-captive <<EOF
#!/bin/sh
mullvad disconnect
notify-send -a "Captive Portal" "VPN Paused" "Sign into the Captive Portal. Your VPN will be re-enabled when you close the window."
firefox -p CAPTIVE http://captive.kuketz.de
wait $!
mullvad connect && notify-send -a "Captive Portal" "VPN Enabled"
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

---

## **Fun Fact (Or Privacy Nightmare)**

On **Android**, Captive Portals **work even with an active VPN** because system apps (like the built-in Captive Portal chooser in Chromium) can **bypass "always-on" and "block other connections" VPN settings**. This is a privacy issue.

---

## **systemd-resolved Settings (Optional)**

For **extra security**, block most DNS queries when the VPN is **not enabled**.

**Captive Portals use LAN-based sites**, so DNS is only needed for the initial HTTP redirect.

### Steps

1. **Switch to root:**
   ```sh
   sudo -i
   ```

2. **Create an override configuration file:**
   ```sh
   mkdir -p /etc/systemd/resolved.conf.d
   cat > /etc/systemd/resolved.conf.d/block-dns-without-vpn.conf <<EOF
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
   ```

3. **Restart `systemd-resolved`:**
   ```sh
   systemctl restart systemd-resolved
   ```

### Issues with This Approach

Even with **Mullvad VPN turned off**, DNS queries may still resolve, which could be a problem.

An alternative solution would be **split-tunneling**, allowing only the browser profile to bypass the VPN. However, while this works on **Android**, it **causes crashes** on some Linux VPN clients.