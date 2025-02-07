# Privacy Settings for Common Apps

This list includes general privacy settings to manually apply in commonly used 
apps.

It is likely not complete, and privacy exists on a gradient.

## System

At the OS level, use a **privacy- and security-optimized OS**. Without 
security, there is no privacy.

There are different use cases for systems:

### Mobile

Use [GrapheneOS](https://grapheneos.org/)—there is nothing better.  
[See my Android Repo for 
tips](https://github.com/trytomakeyouprivate/Android-Tipps).

### Extreme Security

Use [QubesOS](https://www.qubes-os.org) with **certified hardware**, running 
every "task group" in a dedicated [virtualized 
environment](https://en.wikipedia.org/wiki/Virtual_machine).  

- Use **Coreboot** with the **HEADS** payload for measured boot and 
anti-evil-maid attack prevention.
- Use **USBGuard** to protect against malicious USB devices.
- Use a **Nitrokey** to store measured boot information.

### Temporary System, Possibly Untrusted Hardware

Use [Tails](https://tails.net/), which runs on the 
[Tor](https://www.torproject.org/) network, with or without persistent storage. 
 

Note:  
Tails is not optimized for app containerization, malware prevention, or 
bypassing malicious firmware.

### Regular OS for Daily Usage

Use something like [Secureblue](https://github.com/secureblue/secureblue), 
which features:

- **Flatpak apps** ([See my list of 
recommendations](https://github.com/trytomakeyouprivate/recommended-flatpak-apps
))
- **Restricted Podman containers**
- **Virtual machines**

## Hardware

Use **hardware with updated firmware** that is free of backdoors like the 
[Intel ME](https://github.com/corna/me_cleaner?tab=readme-ov-file#intel-me) and 
is as free as possible.  

⚠ **There is no performant, affordable hardware with 100% free firmware!** Keep 
that in mind.  

### Recommended Hardware:

- [Novacustom Laptops](https://configurelaptop.eu/) or 
[PCs](https://docs.dasharo.com/variants/overview/#desktop) with [Dasharo 
Coreboot](https://dasharo.com) ([Code](https://github.com/dasharo))
- [System76](https://system76.com) PCs or laptops with Coreboot support
- [Corebooted Chromebooks](https://mrchromebox.tech/) using 
[MrChromebox](https://mrchromebox.tech/) and 
[Chrultrabook](https://docs.chrultrabook.com/)
- [Libreboot](https://libreboot.org/docs/hardware/) and 
[Coreboot](https://www.coreboot.org/Supported_Chipsets_and_Devices) hardware  
  *(Mostly outdated and vulnerable to 
[Spectre](https://en.wikipedia.org/wiki/Spectre_(security_vulnerability)) & 
[Meltdown](https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability)))*
- **Google Pixel** phones, foldable phones, and tablets for **GrapheneOS**  
  *(See [GrapheneOS' hardware 
requirements](https://grapheneos.org/faq#future-devices) for future devices.)*
