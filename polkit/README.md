Polkit rules to allow certain actions. Prefer to use separate groups, on Fedora

```
# create new group
sudo groupadd udisks2

# add user to group
sudo usermod -aG udisks2 $USER
```

### udisks2
This allows passwordless LUKS unlock and mount of disks using udisks2

### rpm-ostree
This is the hopefully soon upstreamed, more secure rule that restrict rpm-ostree privileges
