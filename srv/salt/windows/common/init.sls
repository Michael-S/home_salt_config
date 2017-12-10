

# I thought I could use nuget, but that is for
# people developing software with .NET.  I need
# the Chocolatey program https://chocolatey.org/


# in order to run the Chocolatey installer,
# we need a PowerShell execution policy check
# unfortunately, I can't figure out a way to do this
# with a check, since powershell return values don't seem to
# fit the 0 success / non-0 failure expected by shell commands or Salt.
Set-ExecutionPolicy RemoteSigned:
  cmd.run:
    - shell: powershell

# just to check...
#Get-ExecutionPolicy:
#  cmd.run:
#    - shell: powershell

Setup-Chocolatey.ps1:
  cmd.script:
    - shell: powershell
    - source: salt://windows/common/files/Setup-Chocolatey.ps1

ChocoPackages.ps1:
  cmd.script:
    - shell: powershell
    - source: salt://windows/common/files/ChocoPackages.ps1

#echo $PSVersionTable.PSVersion:
#  cmd.run:
#    - shell: powershell


