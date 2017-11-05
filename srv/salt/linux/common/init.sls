# Most of this is Ubuntu-specific.
# It would apply to Ubuntu flavors, but additional work would be required
# to make it work with distributions like Fedora, OpenSUSE,
# NixOS, GuixSD

# for some reason this reliably fails when installed with
# plain old 'apt-get install openjdk-9-jdk' or the Salt pkg.installed
# equivalent.  So fix it here.
apt-get -o Dpkg::Options::="--force-overwrite" install -y openjdk-9-jdk:
  cmd.run:
    - unless: dpkg -l | grep '^ii  openjdk-9-jdk:amd64'


always-packages:
  pkg.installed:
    - pkgs:
      # getting software, probably installed by default
      - wget
      - curl
      # For encrypting my Salt private values.
      - gnupg
      # for encrypting passwords and other related tasks
      - openssl
      # for encrypted storage, remember it requires a reboot
      # to work
      - tcplay
      # Because it rocks
      - vim
      # Because I keep meaning to learn it.
      - emacs
      # git and Mercurial for source control
      - git
      - mercurial
      # because I like Lisp and Scheme
      - guile-2.0
      - racket
      - sbcl
      # for general Java development plus minecraft
      - maven
      # image editor
      - gimp
      # command line image manipulation
      - imagemagick
      # usually present, but be explicit
      - firefox
      # remote access
      - openssh-server
      - mosh
      # movie player
      - vlc
      # Libre office
      - libreoffice
      # for ripping DVDs
      - ffmpeg
      - handbrake-cli
      - ubuntu-restricted-extras
      - libdvdcss2
      # for Windows-compatible network shares
      - samba
      # for alternatives to Minecraft I can't get my kids to play
      - minetest
      # the 0 AD free software strategy game.
      - 0ad
      # command line calculator
      - bc


# Minecraft
add-apt-repository -y ppa:flexiondotorg/minecraft ; apt-get update ; apt-get install -y minecraft-installer:
  cmd.run:
    # I don't specify an exact file name because it's different
    # based on the Ubuntu flavor.
    - unless: test -e /etc/apt/sources.list.d/flexiondotorg-ubuntu-minecraft-{{ grains['oscodename'] }}.list

# Chrome software repository public key
chrome-repo-public-key.sh:
  cmd.script:
    - source: salt://linux/common/files/chrome-repo-public-key.sh
    - unless: apt-key list | grep Google

# Chrome browser
/etc/apt/sources.list.d/google-chrome.list:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - contents: deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
    - require:
      - cmd: chrome-repo-public-key.sh

# Install Chrome
apt-get install -y google-chrome-stable:
  cmd.run:
    - unless: dpkg -l | grep google-chrome-stable
    - require:
      - file: /etc/apt/sources.list.d/google-chrome.list

# Kodi latest stable
# ...but it doesn't seem to work right on Ubuntu 17.10
# it hangs.
{% if grains['osrelease'] != '17.10' %}
add-apt-repository -y ppa:team-xbmc/ppa ; apt-get update ;  apt-get install -y kodi:
  cmd.run:
    - unless: dpkg -l | grep kodi
{% else %}
# revert to the default kodi instead of latest stable.
remove-kodi-from-ppa.sh:
  cmd.script:
    - source: salt://linux/common/files/remove-kodi-from-ppa.sh
    - onlyif: test -e /etc/apt/sources.list.d/team-xbmc-ubuntu-ppa-{{ grains['oscodename'] }}.list
{% endif %}

# Microsoft software repository public key
microsoft-repo-public-key.sh:
 cmd.script:
   - source: salt://linux/common/files/microsoft-repo-public-key.sh
   - unless: apt-key list | grep Microsoft

# I only occasionally play with it, but why not?
/etc/apt/sources.list.d/microsoft.list:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://linux/common/files/microsoft.repo.jinja

{# As of 2017-10-31 (Happy Halloween!) PowerShell isn't available for Ubuntu 17.10 yet. #}
{% if grains['osrelease'] != '17.10' %}
# Install PowerShell
apt-get update; apt-get install -y powershell:
  cmd.run:
    - unless: dpkg -l | grep powershell
{% endif %}

setup-firefox-nightly:
  cmd.script:
    - source: salt://linux/common/files/ubuntu-mozilla-daily.sh
    - unless: dpkg -l | grep firefox-trunk

# enable firewall
ufw enable:
  cmd.run:
    - onlyif: ufw status | grep 'inactive'

# add firewall rule for SSH 
ufw allow 22/tcp:
  cmd.run:
    - unless: ufw status | grep '22/tcp.*ALLOW'

# add firewall rule for Mobile Shell (mosh)
ufw allow 60000:61000/udp:
  cmd.run:
    - unless: ufw status | grep '60000:61000/udp.*ALLOW'

 

