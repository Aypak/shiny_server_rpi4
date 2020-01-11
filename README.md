# Shiny Server on Raspberry Pi with R

If you want to use a Raspberry Pi as a Shiny Server, 1) yes the RPi can handle it! 2) this script will allow you to do it effortlessly!

## Installation with Stable R 3.3.3

The provided RPiShinyServer_InstallScript.sh script will install the latest Shiny Server distribution along with R 3.3.3 (stable) simply via the following commands:

```bash
git clone https://github.com/pjaselin/ShinyServer_On_RaspberryPi.git
cd ShinyServer_On_RaspberryPi
bash Stable_RPiShinyServer.sh
```

Regarding performance of the Shiny Server on the Raspberry Pi, the device seems to handle it quite well and I haven't seen any processing/speed issues!

## Important Tasks in the Script
- Handles system library dependencies
- Installs all R packages required for index.html to successfully open
- Edits external/node/install-node.sh for RPi ARM processor
- Builds Shiny Server via packaging/make-package.sh
- Configures Shiny Server, sets up initial server applications
- Resolves Pandoc issues

## Installation with Backport R 3.5.2 (Caution)

NOT FULLY FUNCTIONAL: Due to the new release of R 3.5.2, the R backport will not correctly install the lastest version of R and the required packages. However, Shiny Server will correctly install.

```bash
git clone https://github.com/pjaselin/ShinyServer_On_RaspberryPi.git
cd ShinyServer_On_RaspberryPi
bash Backport_RPiShinyServer.sh
```

## Warnings
This script is provided "as is" with no warranty of any kind. As such, users should read the script to ensure they are confident in its integrity. This has been tested and is known to work with a fresh install of the Jun 6, 2018 v4.14 Raspbian OS (https://www.raspberrypi.org/downloads/raspbian/).

## Maintenance
I will try to keep this updated for new versions of R as well as the other codes found here. As such a more robust script may develop in time. Please submit issues if you run into problems and I'll do my best to make changes to the script as necessary.
