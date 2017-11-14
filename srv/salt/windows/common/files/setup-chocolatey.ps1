<#
PowerShell script to install the Chocolatey utility.

#>

if (-not (Test-Path 'C:\ProgramData\Chocolatey\bin\choco.exe')) {

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

} else {

echo "Chocolately already installed, attempting an upgrade."
& 'C:\ProgramData\Chocolatey\bin\choco.exe' upgrade chocolatey '--yes'
 
}

