#!/bin/bash
# You can't run plain apt-get update; apt-get dist-upgrade -y ; apt-get autoremove -y
# or its YUM/DNF (Red Hat/CentOS/Fedora/OpenSUSE) or ebuild (Gentoo) or similar
# upgrades through Salt the regular ways, because if the Salt software itself
# gets upgraded it interrupts the update process.

apt-mark hold salt-minion
apt-mark hold salt-master
apt-mark hold salt-common
apt-get update
apt-get dist-upgrade -y
apt-get autoremove -y
apt-mark unhold salt-minion
apt-mark unhold salt-master
apt-mark unhold salt-common

