#!/bin/bash
# Install the Mozilla personal package archive for Ubuntu
add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
apt-get update
apt-get install -y firefox-trunk

