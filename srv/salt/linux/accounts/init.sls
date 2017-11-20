# This sets up the Linux accounts on all computers we all use.

{% for user, real, uid, password in [
       (pillar['linuxusername1'], pillar['realname1'], pillar['uid1'], pillar['password1']),
       (pillar['linuxusername2'], pillar['realname2'], pillar['uid2'], pillar['password2']),
       (pillar['linuxusername3'], pillar['realname3'], pillar['uid3'], pillar['password3']),
       (pillar['linuxusername4'], pillar['realname4'], pillar['uid4'], pillar['password4']),
       (pillar['linuxusername5'], pillar['realname5'], pillar['uid5'], pillar['password5']),
       (pillar['linuxusername6'], pillar['realname6'], pillar['uid6'], pillar['password6']) ] %}

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
      {% if user in (pillar['linuxusername1'], pillar['linuxusername2']) %}
      - sudo
      {% endif %}
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
