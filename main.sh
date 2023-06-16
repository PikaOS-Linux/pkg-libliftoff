#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
wget -nv https://gitlab.freedesktop.org/emersion/libliftoff/-/releases/v0.4.1/downloads/libliftoff-0.4.1.tar.gz
tar -xf ./libliftoff-0.4.1.tar.gz
mkdir -p ./libliftoff-0.4.1
cp -rvf ./debian ./libliftoff-0.4.1/
cd ./libliftoff-0.4.1/

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
