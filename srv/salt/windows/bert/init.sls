G:\userdata:
  file.directory:
    - makedirs: True


{% for (user, password) in [
       (pillar['windowsusername1'], pillar['password1']),
       (pillar['windowsusername2'], pillar['password2']),
       (pillar['windowsusername3'], pillar['password3']),
       (pillar['windowsusername4'], pillar['password4']),
       (pillar['windowsusername5'], pillar['password5']),
       (pillar['windowsusername6'], pillar['password6']) ] %}

G:\userdata\{{ user }}:
  file.directory:
    - makedirs: True
    - user: {{ user }}

{% for dirname in ["Desktop", "Documents", "Downloads", "Pictures", "Videos", "Music"] %}
G:\userdata\{{ user }}\{{ dirname }}:
  file.directory:
    - makedirs: True
    - user: {{ user }}

# this does not work, I think it requires Windows 10 Professional and domain accounts.
#. .\Set-KnownFolderPath.ps1; Set-KnownFolderPath -KnownFolder {{ dirname }} {{ user }}:
#  cmd.script:
#    - shell: powershell
#    - source: salt://windows/common/files/Set-KnownFolderPath.ps1
#    - runas: {{ user }}
#    - password: {{ password }}

{% endfor %}

{% endfor %}

