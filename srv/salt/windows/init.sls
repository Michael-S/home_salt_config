
{% if grains['id'] == 'bert' or grains['id'] == 'squidward' %}
include:
  - .common
  - .bert
  - .accounts

{% endif %}
