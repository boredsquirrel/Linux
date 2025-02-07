# Install RStudio on Fedora

Create a Distrobox for Fedora
```bash
distrobox-create Fedora -i registry.fedoraproject.org/fedora-toolbox:$(rpm -E 
%fedora) #or enter version manually
distrobox-enter Fedora
```bash

Add the COPR for all the modules, install the packages
```bash
sudo dnf copr enable iucar/cran
sudo dnf install -y rstudio-desktop R-CoprManager
distrobox-export --app rstudio-desktop
```bash

[List of available R 
modules](https://copr.fedorainfracloud.org/coprs/iucar/cran/packages/)

This is the best method to install RStudio on Linux in general, as they [don't 
seem to manage keeping their software up to date at 
all](https://posit.co/download/rstudio-desktop/)

> [!NOTE]
> RStudio was rewritten from Qt to Electron.
> A very stupid move, according to many people.
> Electron uses an often insecure version of Chromium, with degraded Security, 
is huge, rarely kept up to date etc.
> You might want to look out for an alternative.
> Installing R and the CRAN modules is still recommended using this method.

> [!WARNING]
> Fedora is not made to be ran inside containers.
> The dnf system updater does not work within a podman container, so when the 
current version goes EOL (max. 13 months) you need to recreate a new container.
