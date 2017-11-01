#!/bin/bash
# A simple script to update the actual Salt directories
# from this git copy of the code.
sudo rsync -rv --delete srv/salt/  /srv/salt/
sudo rsync -rv --delete srv/pillar/ /srv/pillar/

