
{% if grains['id'] == 'bert' %}
include:
  - .common
  - .bert
  - .accounts

{% endif %}
