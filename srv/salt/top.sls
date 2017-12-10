# Salt data under /srv/pillar has Pillar data (data for managed machines assigned 
# by the salt master).  Salt data under /srv/salt has Salt states (actual configuration
# settings).
base:

  # the always Linux boxes
  'plankton or daffy':
    - match: compound
    - linux

  # the always Windows boxes
  'bert':
    - windows

  # squidward when booted to Windows
  'squidward and G@os:Windows':
    - windows

  # squidward when booted to Linux
  'squidward and G@os_family:Debian':
    - linux
