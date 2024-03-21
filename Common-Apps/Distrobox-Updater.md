Distrobox makes using Podman containers of various Linux Distributions very easy.

Normally those containers are not updated using package managers, but by pulling new complete container images. 

For the use case of installing apps inside containers, we need to use the builtin package managers though.

Distrobox makes this extremely easy:

```
distrobox upgrade --all
```

We can create a simple systemd service that does this every 3 days automatically:

```
sudo cat > /etc/systemd/system/distrobox-upgrade.service <<EOF
[Unit]
Description=Upgrade all Distroboxes every 3 days
After=network-online.target

[Service]
Type=oneshot
ExecStart='/usr/bin/distrobox upgrade --all'
Nice=15
IOSchedulingClass=idle

[Timer]
OnCalendar=*-*-* 20:00:00
OnActiveSec=3d
Persistent=true

[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now distrobox-upgrade
```

- `Nice=15`: priority from 19 to -20, the higher, the less
- `IOSchedulingClass=idle`: will only run when the PC is idle
- `OnActiveSec=3d`: after running once, it waits 3 days to run again
- `Persistent=true`: if that delay is missed, it will run as soon as it boots up

This will make sure that the service runs in the background, without annoying you.
