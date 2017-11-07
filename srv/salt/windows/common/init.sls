
# Doesn't work, I'll need to keep investigating.
bits-transfer.ps1  https://dist.nuget.org/win-x86-commandline/latest/nuget.exe C:\nuget.exe:
  cmd.script:
    - source: salt://windows/common/files/bits-transfer.ps1
    - cwd: "C:\\"
    - shell: powershell



