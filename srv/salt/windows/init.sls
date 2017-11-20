
{% if grains['id'] == 'bert' %}
include:
  - .common
  - .accounts
  - .bert

{% elif grains['id'] == 'squidward' %}
include:
  - .common
  - .accounts
  - .squidward

{% endif %}
