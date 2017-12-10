# A Home Salt Config

Home Salt config for our house. We have four desktops and two laptops, and
when something goes wrong a rebuild-from-scratch is a real headache.

Since I'm comfortable with [Salt Stack](https://saltstack.com/), I've chosen that. This lets me set up all six accounts for the family members and install almost all of the software we routinely use with just one or two Salt commands.

*Unfortunately, SaltStack isn't aimed at home users. Even worse, Windows 10 Home edition does not support the same remote Salt commands and configuration through PowerShell that Windows 10 Professional managed by an Active Directory server would. So this project is not aimed at casual users of Windows or Linux and is not nearly as 'install and click and everything works' as I would like.*  If I had a chance to do this over, I would have picked some other tool.   

With that disclaimer in mind, if you are going to proceed with Salt:

To get started, you need a recent version of Salt Stack on all of the machines.

Windows installation uses installer
https://docs.saltstack.com/en/latest/topics/installation/windows.html

Ubuntu Linux derivatives have Salt in the official software package repositories,
but I'm not going to test against old versions so I'll use the commands to get the latest version:

    wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

run the command above first, by itself.  Then the lines below can be paste into a terminal all together.

    echo deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main > saltstack.list
    sudo mv saltstack.list /etc/apt/sources.list.d/saltstack.list
    chown root:root /etc/apt/sources.list.d/saltstack.list
    sudo apt-get update
    sudo apt-get install salt-minion salt-master

Again, I'm assuming the reader is familiar with Salt and can connect the minions to the master.

Here are the machines on my network:

    192.168.1.11 plankton - Linux server and workstation, Salt master
    192.168.1.12 squidward - dual boot Linux and Windows PC
    192.168.1.13 bert - Windows PC
    192.168.1.15 daffy - Linux laptop
    192.168.1.18 (omitted) - an unmanaged Windows PC 

For dual-boot machines, you have to make sure to use the same Minion key from /etc/salt/pki/minion (on Linux) or C:\salt\conf\pki\minion (on Windows).  It probably also makes sense to use the same SSH host keys in /etc/ssh (on Linux) and C:\cygwin64\etc (on Windows).

I've found one of the steps that has to be run manually on Windows 10 Home, it can't be run through Salt.  I have small solid state drives for the operating systems, and then I put most of the user folder content onto another much larger traditional hard drive. The graphical process for doing this through Windows is slow, especially for six accounts in succession.  The process to run it through PowerShell is significantly faster.  For machine 'squidward', I copy /srv/salt/windows/squidward/files/MoveUserFolders.ps1 and /srv/salt/windows/common/files/Set-KnownFolderPath.ps1 to the E:\ drive folder userdata, login as each newly created user using the appropriate password, open a powershell to E:\userdata\ and type ```. .\MoveUserFolders.ps1```.  I go through the same process for bert, but /srv/salt/windows/bert/files/MoveUserFolders.ps1 and G:\userdata.  (I could refactor MoveUserFolders.ps1 to be flexible and just use the same file in both places. It works as-is, that's not a priority for me.)

But otherwise, this does more or less what I want.  When one of our computers fails, I reinstall the operating system, install Salt minion, connect it to the master, and run a Salt state.apply from the master. It takes a long time to finish because of the software installations, but when it's done the machine is almost completely set up.
 
License: licensing information is in the LICENSE file in this same directory.
