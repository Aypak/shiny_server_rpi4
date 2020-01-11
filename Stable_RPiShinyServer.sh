# Install R Shiny Server (stable) on Raspberry Pi 3, tested January 11, 2020
# As per: https://github.com/rstudio/shiny-server/issues/347
# and: https://www.rstudio.com/products/shiny/download-server/
# and: https://cloud.r-project.org/bin/linux/debian/#debian-stretch-stable
# and: https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source

# Start at home directory
cd

# Update/Upgrade Raspberry Pi
sudo apt-get -y update && sudo apt-get -y upgrade

# Install R
sudo apt-get -y install r-base

# Install system libraries (dependences for some R packages)
sudo apt-get -y install libssl-dev libcurl4-openssl-dev libboost-atomic-dev

## Uninstall/Reinstall Pandoc (Shouldn't be initially installed but doing this for safety)
sudo apt-get -y remove pandoc
sudo apt-get -y install pandoc

# Install R Packages
## later (as per https://github.com/r-lib/later/issues/73)
git clone https://github.com/r-lib/later.git
sed -i -e 's/PKG_LIBS = -pthread/PKG_LIBS = -pthread -lboost_atomic/g' later/src/Makevars
sudo R CMD INSTALL later

sudo su - -c "R -e \"install.packages('httpuv', repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('plotly', repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rmarkdown', repos='https://cran.rstudio.com/')\""

# Install cmake: https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source#what-if-a-sufficiently-recent-version-of-cmake-isnt-available
wget http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
tar xzf cmake-2.8.11.2.tar.gz
cd cmake-2.8.11.2
./configure
make
sudo make install
sudo apt-get -y update && sudo apt-get -y upgrade

## Return to home directory
cd

# Install Shiny Server as per https://github.com/rstudio/shiny-server/issues/347
## Clone the Shiny Server repository from GitHub
git clone https://github.com/rstudio/shiny-server.git

## Copy the customer install-node.sh into the shiny-server file. This makes sure the right node is downloaded 
## from npm for ARM processors
cp ShinyServer_On_RaspberryPi/stable_support_files/install-node.sh shiny-server/external/node/install-node.sh 

## Edit external/node/install-node.sh for ARM processor
cd shiny-server/

## Build Shiny Server
packaging/make-package.sh

## Return to home directory
cd

## Copy Shiny Server directory to system location
sudo cp -r shiny-server/ /usr/local/

# Place a shortcut to the shiny-server executable in /usr/bin
sudo ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server

#Create shiny user. On some systems, you may need to specify the full path to 'useradd'
sudo useradd -r -m shiny

# Create log, config, and application directories
sudo mkdir -p /var/log/shiny-server
sudo mkdir -p /srv/shiny-server
sudo mkdir -p /var/lib/shiny-server
sudo chown shiny /var/log/shiny-server
sudo mkdir -p /etc/shiny-server

# Return to Shiny Server directory and set shiny-server.conf
cd shiny-server
sudo cp config/default.config /etc/shiny-server/shiny-server.conf
sudo cp -r /usr/local/shiny-server/ext/pandoc .
sudo rm -r /usr/local/shiny-server/ext/pandoc/
# Setup for start at boot: http://docs.rstudio.com/shiny-server/#systemd-redhat-7-ubuntu-15.04-sles-12
# and: https://www.raspberrypi-spy.co.uk/2015/10/how-to-autorun-a-python-script-on-boot-using-systemd/
sed -i -e "s:ExecStart=/usr/bin/env bash -c 'exec /opt/shiny-server/bin/shiny-server >> /var/log/shiny-server.log 2>&1':ExecStart=/usr/bin/shiny-server:g"  config/systemd/shiny-server.service
sed -i -e 's:/env::'  config/systemd/shiny-server.service
sudo cp config/systemd/shiny-server.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/shiny-server.service
sudo systemctl daemon-reload
sudo systemctl enable shiny-server.service

# Final Shiny Server Setup
sudo cp samples/welcome.html /srv/shiny-server/index.html
sudo cp -r samples/sample-apps/ /srv/shiny-server/

sudo shiny-server &
# Return to home directory
cd
