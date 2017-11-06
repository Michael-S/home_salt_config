# we can't put plankton/192.168.1.11 in /etc/hosts
# because plankton had to be there already because
# it needs to contact its salt master.

/etc/hosts:
  file.append:
    - text: |
        192.168.1.12 squidward
        192.168.1.13 bert


