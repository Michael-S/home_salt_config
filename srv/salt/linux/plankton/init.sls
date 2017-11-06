
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
qemu-and-samba-and-anacron-packages:
  pkg.installed:
    - pkgs:
      - qemu-kvm # requires a restart after install, typically
      - virt-manager
      - samba
      - smbclient
      - anacron

/etc/fstab:
  file.managed:
    - user: root
    - group: root
    - source: salt://linux/plankton/files/plankton_fstab
    - mode: 644

/media/sda2:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/media/sdb2:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/media/sdd2:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/media/sdc1:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

# Samba config
/etc/samba/smb.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://linux/plankton/files/plankton_smb.conf
    - makedirs: True

# backup process config
/root/backup_process:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

/root/backup_process/bert_rsync.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True
    - source: salt://linux/plankton/files/bert_rsync.sh.jinja
    - template: jinja

/root/backup_process/plankton_squidward_rsync.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True
    - source: salt://linux/plankton/files/plankton_squidward_rsync.sh.jinja
    - template: jinja

/root/backup_process/weekly_rsync.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True
    - source: salt://linux/plankton/files/weekly_rsync.sh.jinja
    - template: jinja

# Anacrontab to run the backup scripts
/etc/anacrontab:
  file.append:
    - text: |
        3       15      plankton_squidward_rsync  /root/backup_process/plankton_squidward_rsync.sh
        3       45      bert_rsync                /root/backup_process/bert_rsync.sh
        7       30      weekly_rsync              /root/backup_process/weekly_rsync.sh


