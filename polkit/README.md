# Polkit Rules for Specific Actions

Polkit rules allow certain actions without requiring `sudo` access. Place them in:  
`/etc/polkit-1/rules.d/`

> **Note:**  
> The old `.pkla` format is deprecated and should not be used.

Both polkit rules below allow specific privileges without requiring the user to have `sudo` access.

[Use this script](https://github.com/boredsquirrel/unsudo) to add a dedicated admin user and remove these privileges from your normal user.

---

## udisks2

> **Warning:**  
> Normally, devices detected as "removable" (pendrives, external hard drives, etc.) should not require a password.  
> However, some external devices are not detected correctly.  
> This is a **dirty workaround**—instead, **udev rules** should be used.  
> [Read this forum post with an explanation](https://discussion.fedoraproject.org/t/f42-change-proposal-unprivileged-disk-management-system-wide/124334/23).

This rule allows passwordless **LUKS unlock and mounting of all disks** using **udisks2**.

### Use Separate Groups Per Privilege

On **Fedora**, create and assign a dedicated group:

```sh
sudo sh -c '
    # create new group
    groupadd udisks2
    # add user to group
    usermod -aG udisks2 $USER
'
```

---

## libvirt

> **Warning:**  
> This rule allows regular users to access **root-level virtualization**.  
> A user can exploit this to **escalate privileges**.

Instead, **use a "QEMU user session"** in **virt-manager** or **GNOME Boxes**.

If you **must** open this attack vector (e.g., for GPU forwarding), create and use a dedicated group:

```sh
sudo sh -c '
    # create new group
    groupadd libvirt
    # add user to group
    usermod -aG libvirt $USER
'
```

---

## rpm-ostree

This rule **has already been upstreamed** and does not require manual intervention.