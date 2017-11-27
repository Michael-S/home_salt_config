E:\userdata:
  file.directory:
    - makedirs: True

E:\userdata\Set-KnownFolderPath.ps1:
  file.managed:
    - source: salt://windows/common/files/Set-KnownFolderPath.ps1
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

E:\userdata\{{ user }}:
  file.directory:
    - makedirs: True
    - user: {{ user }}

{% for dirname in ["Desktop", "Documents", "Downloads", "Pictures", "Videos", "Music"] %}
E:\userdata\{{ user }}\{{ dirname }}:
  file.directory:
   - makedirs: True
   - user: {{ user }}
{% endfor %}

{% endfor %}

