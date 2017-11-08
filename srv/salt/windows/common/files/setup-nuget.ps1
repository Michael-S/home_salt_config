<#
PowerShell script to install the Nuget utility.

#>

if (-not (Test-Path 'C:\nuget\nuget.exe')) {

$start_time = Get-Date

(New-Object System.Net.WebClient).DownloadFile('https://dist.nuget.org/win-x86-commandline/latest/nuget.exe', 'C:\nuget\nuget.exe')

Write-Output "Time taken to download nuget.exe: $((Get-Date).Subtract($start_time).Seconds) second(s)"

} else {

echo "C:\nuget\nuget.exe already exists."

}

