# Install R and Shiny Server on Raspberry Pi 4

If you want to use a Raspberry Pi as a Shiny Server, 1) yes the RPi can handle it! 2) this script will allow you to do it effortlessly!

Based on [ShinyServer_On_RaspberryPi](https://github.com/pjaselin/ShinyServer_On_RaspberryPi)

## Installation with Stable R (3.6.3 at time of writing)

The provided RPiShinyServer_InstallScript.sh script will install the latest Shiny Server distribution along with R 3.6.3 (stable) simply via the following commands:

```bash
git clone https://github.com/Aypak/shiny_server_rpi4.git
cd shiny_server_rpi4.git
bash Stable_RPiShinyServer.sh
```

Regarding performance of the Shiny Server on the Raspberry Pi, the device seems to handle it quite well and I haven't seen any processing/speed issues!

## Important Tasks in the Script
- Handles system library dependencies
- Installs all R packages required for sample applications to open
- Edits external/node/install-node.sh for RPi ARM64 processor
- Builds Shiny Server package
- Configures Shiny Server, and sets up sample applications

## Warnings
This script is provided "as is" with no warranty of any kind. As such, users should read the script to ensure they are confident in its integrity. This has been tested and is known to work with a fresh install of [Ubuntu Server 20.04 Rpi build](http://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz) on Raspberry Pi 4 (4GB RAM). See (https://www.raspberrypi.org/downloads/raspbian/) for other Raspberry Pi operating systems.

## Maintenance
I will try to keep this updated for new versions of R as well as the other code found here. As such a more robust script may develop in time. Please submit issues if you run into problems and I'll do my best to make changes to the script as necessary.
