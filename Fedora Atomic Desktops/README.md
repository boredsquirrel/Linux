## Reinstall packages that were uninstalled on the image build
If projects (most prominently "universal blue" or "secureblue") take a Fedora image and remove package during the image build process, [like here](https://github.com/secureblue/secureblue/blob/d6897883057c02cec51330aa96611a1499f6cc32/recipes/common/desktop-packages.yml#L29) [or here](https://github.com/ublue-os/bluefin/blob/1c46a452d8690fe2464cbaf73073e63fe0a73ea3/packages.json#L171) the user normally cannot install them again.

Background is, that rpm-ostree does not really allow uninstalling packages, so you always download all of them and the removal happens *after* you have downloaded the entire image. This means that you also can't remove packages to make updates faster, they will become slower.

For some reason, while added packages are added to the image that for example "universal blue" ships, removed packages are still only removed on the end user's PC. Or at least, rpm-ostree seems to think so.

The result is, that if "universal blue" remove Fedora Firefox (which is really good, and no Flathub Firefox is not secure and not an alternative), you can't reinstall it.

Unless... you use the workaround that "RoyalOughtness" found [in this thread](https://github.com/coreos/rpm-ostree/issues/4554#issuecomment-2453664741). You just need to install a package that *requires* the removed packages, and the removed packages will be installed again!

Now you can search for these packages with dnf (and I made a script in fish for that which I upload here for fun) but in the case of Firefox, unless you are on GNOME, all such packages will add unnecessary bloat to the system. (the package with least additional requirements is a kiosk package, which pulls in the entire `gnome-session`).

So instead, create a local RPM package with no contents, that requires all the packages you want! I made a script which uses firefox, but you can add as many packages as you want.
