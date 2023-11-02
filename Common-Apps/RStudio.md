# Install RStudio on Fedora

Create a Distrobox for Fedora 39
```
distrobox-create Fedora39 -i registry.fedoraproject.org/fedora-toolbox:39
distrobox-enter Fedora39
```

Add the COPR for all the modules, install the packages
```
sudo dnf copr enable iucar/cran
sudo dnf install -y rstudio-desktop R-CoprManager
distrobox-export --app rstudio-desktop
```
