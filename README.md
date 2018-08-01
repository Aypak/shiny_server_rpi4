# Shiny Server On Raspberry Pi with R 3.5.1 (Feather Spray)

The provided RPiShinyServer_InstallScript.sh script will install the latest Shiny Server distribution along with R 3.5.1 (Feather Spray) simply via the following commands:
```
wget https://raw.githubusercontent.com/pjaselin/ShinyServerOnRPi/master/RPiShinyServer_InstallScript.sh
bash RPiShinyServer_InstallScript.sh
```

## Important Tasks in the Script
- Adds backport for R 3.5.1
- Handles system library dependencies
- Installs all R packages required for index.html to successfully open
- Edits external/node/install-node.sh for RPi ARM processor
- Builds Shiny Server via packaging/make-package.sh
- Configures Shiny Server, sets up initial server applications
- Resolves Pandoc issues


## Warnings
This script is provided "as is" with no warranty of any kind. As such, users should read the script to ensure they are confident in its integrity. This has only be tested and is known to work with a fresh install of the Jun 6, 2014 v4.14 Raspbian OS (https://www.raspberrypi.org/downloads/raspbian/).
