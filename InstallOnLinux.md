Install on Linux/Ubuntu
=======================

Installing PCDERAD0633, Ubuntu 1604 (PCDERAD0339-aug, Linux Partition!)
-----------------------------------------------------------------------

### Install
Fehlende Pakete:
- sudo apt-get install quilt
- sudo apt-get install alsa
- (sudo apt-get install apt-file  - nur zur Fehlersuche?)
- sudo apt-get install libasound2-dev
- sudo apt-get install libcurl4-openssl-dev (statt nur libcurl)
***
- sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y &&
- sudo apt-get update -y &&
- sudo apt-get install gcc-snapshot -y &&
- sudo apt-get install gcc-9 g++-9 -y
- sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9 &&
- sudo update-alternatives --config gcc
***
- sudo apt-get install libglm-dev
- sudo apt-get install 
- sudo apt-get install make g++ \
  zlib1g-dev \
  libsdl1.2-dev libfreetype6-dev \
  libpng-dev libjpeg-dev \
  libcurl4-openssl-dev \
  libxml-parser-perl \
  librsvg2-bin xsltproc \
  imagemagick gettext \
  fonts-dejavu \
  lua5.2 \
  liblua5.2-dev -y
