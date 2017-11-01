# This is the master file for the Salt states for Linux servers.
# Everything farms out from here.

{% if grains['id'] == 'plankton' %}
include:
  - .common
  - .plankton

{% elif grains['id'] == 'squidward' %}
include:
  - .common
  - .squidward

{% elif grains['id'] == 'tweety' %}
include:
  - .common
  - .squidward

{% endif %}

