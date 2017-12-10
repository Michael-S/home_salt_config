#!/bin/bash
# A simple script to update the actual Salt master directories
# from this copy of the code in the current directory.
sudo rsync -rv --delete srv/salt/  /srv/salt/
sudo rsync -rv --delete srv/pillar/ /srv/pillar/

