# Install R Shiny Server on Raspberry Pi 3, tested July 31, 2018
# As per: https://github.com/rstudio/shiny-server/issues/347
# and: https://www.rstudio.com/products/shiny/download-server/
# and: https://cloud.r-project.org/bin/linux/debian/#debian-stretch-stable
# and: https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source

# Start at home directory
cd

# Update/Upgrade Raspberry Pi
sudo apt-get -y update && sudo apt-get -y upgrade

# Add newest R repository: https://cloud.r-project.org/bin/linux/debian/#debian-stretch-stable
## Add backport to /etc/apt/sources.list
echo 'deb http://cloud.r-project.org/bin/linux/debian stretch-cran35/' | sudo tee --append /etc/apt/sources.list
## Add apt-key for backport
sudo apt-get install dirmngr --install-recommends
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
sudo apt-get -y update && sudo apt-get -y upgrade

# Install R
sudo apt-get -y install r-base r-base-dev

# Install system libraries (dependences for some R packages)
sudo apt-get -y install libssl-dev libcurl4-openssl-dev
## Uninstall/Reinstall Pandoc
sudo apt-get -y remove pandoc
sudo apt-get -y install pandoc

# Install R Packages
sudo su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('plotly', repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('markdown', repos='https://cran.rstudio.com/')\""
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
## Clone the repository from GitHub
git clone https://github.com/rstudio/shiny-server.git

## Edit external/node/install-node.sh for ARM processor
cd shiny-server/
### update NODE_SHA256 as per: https://nodejs.org/dist/v8.11.3/SHASUMS256.txt
sed -i -e 's/08e2fcfea66746bd966ea3a89f26851f1238d96f86c33eaf6274f67fce58421a/7a2bb6e37615fa45926ac0ad4e5ecda4a98e2956e468dedc337117bfbae0ac68/g' external/node/install-node.sh
### update NODE_FILENAME
sed -i -e 's/x64/armv7l/g' external/node/install-node.sh

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
sudo cp config/systemd/shiny-server.service /etc/systemd/system/
sudo systemctl enable shiny-server


# Final Shiny Server Setup
sudo cp samples/welcome.html /srv/shiny-server/index.html
sudo cp -r samples/sample-apps/ /srv/shiny-server/

sudo shiny-server &
