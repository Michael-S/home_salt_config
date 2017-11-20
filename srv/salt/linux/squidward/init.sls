
# we don't put 'plankton/192.168.1.11' in /etc/hosts because it needed
# to be there already for Salt to be set up.

/etc/hosts:
  file.append:
    - text: |
        192.168.1.13 bert

/etc/fstab:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://linux/squidward/files/squidward_fstab

# mount points
/media/sdb1:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/media/sdc2_windows:
  file.directory:
    - user: root
    - group: root
    # mounted NTFS drives get the 777 perms
    - mode: 777
    - makedirs: True

/media/sdc3_linux:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/media/sdd1_f_drive:
  file.directory:
    - user: root
    - group: root
    # mounted NTFS drives get the 777 perms
    - mode: 777
    - makedirs: True

