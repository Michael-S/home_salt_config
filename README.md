# A Home Salt Config

Home Salt config for our house. We have four desktops and two laptops, and
when something goes wrong a rebuild-from-scratch is a real headache.

Since I'm comfortable with [Salt Stack](https://saltstack.com/), I've chosen that.


To get started, you need a recent version of Salt Stack on all of the machines.

Windows installation requires Python 3 and the installer
https://docs.saltstack.com/en/latest/topics/installation/windows.html

Ubuntu Linux derivatives have Salt in the official software package repositories,
but I'm not going to test against old versions so I'll use their commands to get the latest version:

wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
# run the command above first, by itself.  Then the lines below can be paste into a terminal all together.
echo deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main > saltstack.list
sudo mv saltstack.list /etc/apt/sources.list.d/saltstack.list
chown root:root /etc/apt/sources.list.d/saltstack.list
sudo apt-get update
sudo apt-get install salt-minion salt-master


