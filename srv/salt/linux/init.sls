# This is the master file for the Salt states for Linux servers.
# Everything farms out from here.

{% if grains['id'] == 'plankton' %}
include:
  - .common
  - .plankton
  - .accounts

{% elif grains['id'] == 'squidward' %}
include:
  - .common
  - .squidward
  - .accounts

{% elif grains['id'] == 'daffy' %}
include:
  - .common
  - .daffy
  # no .accounts, this device just belongs to one family member

{% endif %}

