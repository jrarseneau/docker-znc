#! /usr/bin/env bash
set -e

# Ensure package list is up to date.
apt-get update

# Install build dependencies.
apt-get install -y wget build-essential libssl-dev libperl-dev pkg-config


# Prepare building
mkdir -p /src


# Download, compile and install ZNC.
cd /src
echo "Version: $ZNC_VERSION"
if [ $ZNC_VERSION ]; then wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz";
else wget "http://znc.in/releases/znc-latest.tar.gz"; fi

tar -zxf "znc-latest.tar.gz"
cd znc-*
./configure && make && make install


# Clean up
apt-get remove -y wget
apt-get autoremove -y
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
