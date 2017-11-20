# we can't put plankton/192.168.1.11 in /etc/hosts
# because plankton had to be there already because
# it needs to contact its salt master.

/etc/hosts:
  file.append:
    - text: |
        192.168.1.12 squidward
        192.168.1.13 bert

{% for user, real, uid, password in [
       (pillar['linuxusername1'], pillar['realname1'], pillar['uid1'], pillar['password1']),
       (pillar['linuxusername2'], pillar['realname2'], pillar['uid2'], pillar['password2']) ] %}

# make the user and group
user-{{ user }}:
  user.present:
    - name: {{ user }}
    - uid: {{ uid }}
    - gid: {{ uid }}
    - fullname: {{ real }}
    - password: {{ password }}
    - hash_password: True
    - groups:
      - adm
      - cdrom
      - sudo
      - dip
      - plugdev
      - lpadmin
      - sambashare
    - remove_groups: False

# make sure the user has a /home/user/.ssh directory
ssh-dir-{{ user }}:
  file.directory:
    - name: /home/{{ user }}/.ssh
    - user: {{ user }}
    - group: {{ user }}
    - dir_mode: 700
    - require:
      - user: user-{{ user }}


{% endfor %}

