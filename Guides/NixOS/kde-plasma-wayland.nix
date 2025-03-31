# Enable SDDM and Plasma6
services.displayManager.sddm.enable = true ;
services.desktopManager.plasma6.enable = true ;

# KDE Plasma in Wayland
services.displayManager.defaultSession = "plasma" ;

# SDDM in Wayland
services.displayManager.sddm.wayland.enable = true ;

services.flatpak.enable = true ;

environment.plasma6.excludePackages = with pkgs.kdePackages; [
  oxygen
  elisa
];

environment.systemPackages = with pkgs; [
    kate
    discover
];
