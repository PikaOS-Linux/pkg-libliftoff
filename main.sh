#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
apt install pika-sources.deb --yes --option Acquire::Retries=5 --option Acquire::http::Timeout=100 --option Dpkg::Options::="--force-confnew"
# Clone Upstream
wget -nv https://gitlab.freedesktop.org/emersion/libliftoff/-/releases/v0.4.1/downloads/libliftoff-0.4.1.tar.gz
tar -xf ./libliftoff-0.4.1.tar.gz
mkdir -p ./libliftoff-0.4.1
cp -rvf ./debian ./libliftoff-0.4.1/
cd ./libliftoff-0.4.1/

# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
