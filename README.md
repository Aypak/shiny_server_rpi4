# CAUTION

NOT FULLY FUNCTIONAL: Due to the new release of R 3.5.2, the R backport will not correctly install the lastest version of R and the required packages. However, Shiny Server will correctly install. Following from this, I'll work on developing a second script that installs the stable R 3.3.3 with Shiny Server.

# Shiny Server On Raspberry Pi with R 3.5.1 (Feather Spray)

The provided RPiShinyServer_InstallScript.sh script will install the latest Shiny Server distribution along with R 3.5.1 (Feather Spray) simply via the following commands:
```
wget https://raw.githubusercontent.com/pjaselin/ShinyServer_On_RaspberryPi/master/RPiShinyServer_InstallScript.sh
bash RPiShinyServer_InstallScript.sh
```
Note that this will take several hours to complete!

Regarding performance of the Shiny Server on the Raspberry Pi, the device seems to handle it quite well and I haven't seen any processing/speed issues!

## Important Tasks in the Script
- Adds backport for R 3.5.1
- Handles system library dependencies
- Installs all R packages required for index.html to successfully open
- Edits external/node/install-node.sh for RPi ARM processor
- Builds Shiny Server via packaging/make-package.sh
- Configures Shiny Server, sets up initial server applications
- Resolves Pandoc issues


## Warnings
This script is provided "as is" with no warranty of any kind. As such, users should read the script to ensure they are confident in its integrity. This has been tested and is known to work with a fresh install of the Jun 6, 2018 v4.14 Raspbian OS (https://www.raspberrypi.org/downloads/raspbian/).

## Maintenance
I will try to keep this updated for new versions of R as well as the other codes found here. As such a more robust script may develop in time. Please submit issues if you run into problems and I'll do my best to make changes to the script as necessary.
