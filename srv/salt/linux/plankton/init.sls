
/etc/hosts:
  file.append:
    - text: |
        192.168.1.12 squidward 
        192.168.1.13 bert

# Firewall 

# Hosted Sandstorm 80 and 443
ufw allow 80/tcp:
  cmd.run:
    - unless: ufw status | grep '80/tcp.*ALLOW'

ufw allow 443/tcp:
  cmd.run:
    - unless: ufw status | grep '443/tcp.*ALLOW'

# Salt itself
ufw allow 4505:4506/tcp:
  cmd.run:
    - unless: ufw status | grep '4505:4506/tcp.*ALLOW'

# Samba
ufw allow 137:139/tcp:
  cmd.run:
    - unless: ufw status | grep '137:139/tcp.*ALLOW'


ufw allow 389/tcp:
  cmd.run:
    - unless: ufw status | grep '389/tcp.*ALLOW'

ufw allow 445/tcp:
  cmd.run:
    - unless: ufw status | grep '445/tcp.*ALLOW'

# bittorrent
# note that for bittorrent to work properly, I have to have my
# home firewall forward bittorrent traffic to these ports.
ufw allow 65001/tcp:
  cmd.run:
    - unless: ufw status | grep '65001/tcp.*ALLOW'

ufw allow 65001/udp:
  cmd.run:
    - unless: ufw status | grep '65001/udp.*ALLOW'

# Additional software packages only on this machine
qemu-and-samba-packages:
  pkg.installed:
    - pkgs:
      - qemu-kvm # requires a restart after install, typically
      - virt-manager
      - samba
      - smbclient

