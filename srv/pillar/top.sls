# Salt 'States' under /srv/salt have the configuration data.
# Salt 'Pillars' under /srv/pillar have variables assigned to managed machines
base:
  '*':
    - all


