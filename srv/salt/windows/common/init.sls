
# make a directory to put the nuget.exe program
C:\nuget:
  file.directory: []

# install nuget.exe
setup-nuget.ps1:
  cmd.script:
    - source: salt://windows/common/files/setup-nuget.ps1
    - shell: powershell

# have nuget.exe update itself, if it's already installed
C:\nuget\nuget.exe update -self:
  cmd.run: []



