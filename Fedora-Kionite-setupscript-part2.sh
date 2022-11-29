#!/bin/bash

echo "Installing and setting up Waydroid"

sudo waydroid init -c https://ota.waydro.id/system -v https://ota.waydro.id/vendor
sudo waydroid container start
waydroid session start
waydroid show-full-ui
waydroid prop set persist.waydroid.multi_windows true
