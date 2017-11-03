
# we don't put 'plankton/192.168.1.11' in /etc/hosts because it needed
# to be there already for Salt to be set up.

/etc/hosts:
  file.append:
    - text: |
        192.168.1.13 bert


