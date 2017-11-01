# This is for system sofware upgrades.

system-software-update.sh:
  cmd.script:
    - source: salt://linux/common/files/system-software-update.sh

# This will cause the Salt-Minion software to be upgraded independently
# and in a safe way.
# It would technically also cause an install, but since the minion
# can't be running unless it's already installed, that would never happen.
salt-minion:
  pkg.installed: []
