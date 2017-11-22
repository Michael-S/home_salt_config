

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


# We need some authorization privileges that admin accounts don't get by default
# seTakeOwnershipPrivilege, SeRestorePrivilege and SeBackupPrivilege

C:\Windows\Temp\UserRights.ps1:
  file.managed:
    - source: salt://windows/accounts/files/UserRights.ps1

# Give the account Salt runs over those privileges.
# ... doesn't seem to work, I get PowerShell errors and this appears
# to be a known issue for local admin accounts and some of the scripts
# I use.
C:\Windows\Temp\FileManagementPrivileges.ps1 -admin:
  cmd.script:
    - source: salt://windows/accounts/files/FileManagementPrivileges.ps1
    - shell: powershell
    - env:
       - adminuser: Administrator

# make two users admin
# and grant them those privileges
{% for user in [(pillar['windowsusername1']), (pillar['windowsusername2'])] %}
makeadmin-{{ user }}:
  cmd.script:
    - name: setadmin.ps1
    - source: salt://windows/accounts/files/setadmin.ps1
    - shell: powershell
    - env:
      - shouldbeadminusername: "{{ user }}"

C:\Windows\Temp\FileManagementPrivileges.ps1 -{{ user }}:
  cmd.script:
    - source: salt://windows/accounts/files/FileManagementPrivileges.ps1
    - shell: powershell
    - env:
       - adminuser: {{ user }}

{% endfor %}

# make all users part of the Windows 'Users' group
{% for user in [pillar['windowsusername1'], pillar['windowsusername2'], pillar['windowsusername3'],
                pillar['windowsusername4'], pillar['windowsusername5'], pillar['windowsusername6']] %}

C:\Windows\Temp\MakeAccountsUsers-{{user}}:
  cmd.script:
    - source: salt://windows/accounts/files/MakeAccountsUsers.ps1
    - shell: powershell
    - env:
      - usertomanage: {{ user }}


{% endfor %}
