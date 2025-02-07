# Polkit Rules  

Polkit rules to allow certain actions. Place them in `/etc/polkit-1/rules.d/`.  

> **Note:** The old pkla format is deprecated and should not be used.  

Both polkit rules allow specific privileges without requiring the user to have
`sudo` access.  

[Use this script](https://github.com/boredsquirrel/unsudo) to add a dedicated
admin user and remove these privileges from your normal user.  

## udisks2  

> **Warning:**  
> Normally, devices detected as "removable" (pendrives, external hard drives,
etc.) should not require a password.  
> However, some external devices are not detected correctly.  
> Using this is a dirty workaround; instead, udev rules should be used.  
> [Read this forum post with an
explanation](<<https://discussion.fedoraproject.org/t/f42-change-proposal-unprivi>
l>
eged-disk-management-system-wide/124334/23).  

This allows passwordless LUKS unlock and mount of ***ALL*** disks using
udisks2.  

Prefer to use separate groups per privilege. On Fedora:  

```sh
sudo groupadd udisks2
sudo usermod -aG udisks2 $USER
```bash

## libvirt  

> **Warning:**  
> This rule allows regular users to access root-level virtualization.  
> This can be used by a user to elevate their privileges.  

Instead, use a "QEMU user session" in virt-manager or GNOME Boxes.  

If you really want to open this attack vector (for example, for GPU
forwarding), use a dedicated group:  

```sh
sudo groupadd libvirt
sudo usermod -aG libvirt $USER
```bash

## rpm-ostree  

The rule was upstreamed.

```bash

This version is correctly formatted, ensuring it won't break your CI pipeline. 
Let me know if you need anything else.
