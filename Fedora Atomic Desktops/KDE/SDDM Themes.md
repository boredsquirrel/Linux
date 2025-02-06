If you want to install SDDM themes on Fedora Atomic Desktops, there are multiple ways to do so.

By default, the SDDM themes are installed in a system-reserved location, which also breaks global themes.

## Edit the config file

Discussion Topics
- [Topic 1](https://discussion.fedoraproject.org/t/another-way-to-customize-sddm-under-kinoite/37773)
- [Topic 2](https://discussion.fedoraproject.org/t/sddm-themeing-or-lack-thereof/32695/2)

Create an override conf where you change the `ThemeDir` variable:

```
runo sh -c '
    mkdir -p /var/usrlocal/share/sddm/themes
    cp -R /usr/share/sddm/themes/* /var/usrlocal/share/sddm/themes/
    mkdir /etc/sddm.conf.d
    echo "ThemeDir='/var/usrlocal/share/sddm/themes'" > /etc/sddm.conf.d/mutable-themes.conf
'
```

This will make the KDE Settings work, you can install custom themes, but you will not get theme updates by the distribution. To get updated themes from the distribution, use

```
run0 cp -Rf /usr/share/sddm/themes/* /var/usrlocal/share/sddm/themes/
```

## The RPM workaround

See the second topic above.

[Lunas Github repo](https://github.com/advaithm/sddm2rpm)

install:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cd ~
cargo init
cargo install sddm2rpm
```

Download an RPM theme archive, and convert it using the tool. Then layer the RPM using `rpm-ostree install theme.rpm`

## The real solution

[see this Github issue on SDDM to support multiple theme directories](https://github.com/sddm/sddm/issues/1561)

[the matching merge request](https://github.com/sddm/sddm/pull/1739)
