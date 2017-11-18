
# For some reason using Salt file.managed to make the G:\userdata folder
# didn't work, so I'm doing it through a powershell script.
makeuserdata.ps1:
  cmd.script:
    - shell: powershell
    - source: salt://windows/bert/files/makeuserdata.ps1

G:\userdata\Set-KnownFolderPath.ps1:
  file.managed:
    - source: salt://windows/bert/files/Set-KnownFolderPath.ps1
    - win_owner: {{ pillar['windowsusername1'] }}
    - win_perms:
        {% for user in [
            (pillar['windowsusername1']), (pillar['windowsusername2']), (pillar['windowsusername3']),
            (pillar['windowsusername4']), (pillar['windowsusername5']), (pillar['windowsusername6']) ] %}
        - {{ user }}:
          perms: full_control
        {% endfor %}

{% for user in [
       (pillar['windowsusername1']), (pillar['windowsusername2']), (pillar['windowsusername3']),
       (pillar['windowsusername4']), (pillar['windowsusername5']), (pillar['windowsusername6']) ] %}

G:\userdata\{{ user }}:
  file.directory:
    - makedirs: True
    - user: {{ user }}

{% for dirname in ["Desktop", "Documents", "Downloads", "Pictures", "Videos", "Music"] %}
G:\userdata\{{ user }}\{{ dirname }}:
  file.directory:
   - makedirs: True
   - user: {{ user }}
{% endfor %}

{% endfor %}

