# Install RStudio on Fedora

Create a Distrobox for Fedora
```
distrobox-create Fedora -i registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora) #or enter version manually
distrobox-enter Fedora
```

Add the COPR for all the modules, install the packages
```
sudo dnf copr enable iucar/cran
sudo dnf install -y rstudio-desktop R-CoprManager
distrobox-export --app rstudio-desktop
```

[List of available R modules](https://copr.fedorainfracloud.org/coprs/iucar/cran/packages/)

This is the best method to install RStudio on Linux in general, as they [don't seem to manage keeping their software up to date at all](https://posit.co/download/rstudio-desktop/)
