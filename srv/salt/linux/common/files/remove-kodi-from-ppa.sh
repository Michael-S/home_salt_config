#!/bin/bash
# remove the PPA version of Kodi
apt-get remove -y kodi
# clean out any cruft from that install
apt-get autoremove -y
# Disable the kodi PPA
add-apt-repository -r -y ppa:team-xbmc/ppa
# Remove the kodi PPA file
rm -fr /etc/apt/sources.list.d/team-xbmc-ubuntu-ppa*
# install default kodi
apt-get install -y kodi

