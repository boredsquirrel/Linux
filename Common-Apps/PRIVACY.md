This list will include some general privacy settings to manually apply in commonly used apps.

It is likely not complete, and privacy is a gradient. 

# System
On the OS level, use a privacy and security optimized OS. Without security there is no privacy.

There are very different use cases for systems.

**Mobile**: Use [GrapheneOS](https://grapheneos.org/), there is nothing better. [See my Android Repo for tips](https://github.com/trytomakeyouprivate/Android-Tipps).

**Extreme Security**: [QubesOS](https://www.qubes-os.org) with certified hardware, running every "task group" in a dedicated [virtualized environment](https://en.wikipedia.org/wiki/Virtual_machine). 

**Temporary system, tiny footprint**: [Tails](https://tails.net/), using the [Tor](https://www.torproject.org) network, with or without persistant storage.

**Regular OS for daily usage**: Something like [Secureblue](https://github.com/secureblue/secureblue), using Flatpak apps ([See my list of recommendations](https://github.com/trytomakeyouprivate/recommended-flatpak-apps)) or virtual machines.

Use hardware with updated firmware that is free of backdoors like the [Intel ME](https://github.com/corna/me_cleaner?tab=readme-ov-file#intel-me) and is as free as possible. There is no performant, affordable hardware with 100% free firmware, keep that in mind! Recommended Hardware:
- [Novacustom Laptops](https://configurelaptop.eu/) or [PCs](https://docs.dasharo.com/variants/overview/#desktop) with [Dasharo Coreboot](https://dasharo.com) ([Code](https://github.com/dasharo))
- [System76](https://system76.com) PCs or Laptops with coreboot support
- [Corebooted Chromebooks](https://mrchromebox.tech/) using Mrchromebox' and [Chrultrabook](https://docs.chrultrabook.com/)'s work
- [Libreboot](https://libreboot.org/docs/hardware/) and [Coreboot](https://www.coreboot.org/Supported_Chipsets_and_Devices) Hardware (mostly outdated and vulnerable to [Spectre](https://en.wikipedia.org/wiki/Spectre_(security_vulnerability)) & [Meltdown](https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability))!)
- Google Pixel phones for GrapheneOS (see [their hardware requirements](https://grapheneos.org/faq#future-devices) for future devices)
