Situation: you installed some random .deb and its broken, can't be removed or 
uninstalled. Here is a solution for it

```
sudo -i
```

```
dpkg -l | grep PACKAGENAME
cd /var/lib/dpkg/info
ls PACKAGENAME*
# confirm they are all correct
rm PACKAGENAME*
sudo dpkg --remove --force-remove-reinstreq PACKAGENAME
sudo apt autoremove
sudo apt update && sudo apt upgrade
```

Done! Damn this is weird
