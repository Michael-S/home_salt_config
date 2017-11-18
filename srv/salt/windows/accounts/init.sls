

{% for user, real, uid, password in [
       (pillar['windowsusername1'], pillar['realname1'], pillar['uid1'], pillar['password1']),
       (pillar['windowsusername2'], pillar['realname2'], pillar['uid2'], pillar['password2']),
       (pillar['windowsusername3'], pillar['realname3'], pillar['uid3'], pillar['password3']),
       (pillar['windowsusername4'], pillar['realname4'], pillar['uid4'], pillar['password4']),
       (pillar['windowsusername5'], pillar['realname5'], pillar['uid5'], pillar['password5']),
       (pillar['windowsusername6'], pillar['realname6'], pillar['uid6'], pillar['password6']) ] %}

# make the user and group
user-{{ user }}:
  user.present:
    - name: {{ user }}
    - fullname: {{ real }}
    - password: {{ password }}

{% endfor %}

# make two users admin
{% for user in [(pillar['windowsusername1']), (pillar['windowsusername2'])] %}
makeadmin-{{ user }}:
  cmd.script:
    - name: setadmin.ps1
    - source: salt://windows/accounts/files/setadmin.ps1
    - shell: powershell
    - env:
      - shouldbeadminusername: "{{ user }}" 


{% endfor %}

# We need some authorization privileges that admin accounts don't get by default
# seTakeOwnershipPrivilege, SeRestorePrivilege and SeBackupPrivilege

