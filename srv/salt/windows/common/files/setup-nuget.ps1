<# 
PowerShell script to install the Nuget utility.

#>

$start_time = Get-Date

(New-Object System.Net.WebClient).DownloadFile('https://dist.nuget.org/win-x86-commandline/latest/nuget.exe', $env:temp + '\nuget.exe')

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

$env:temp + '\nuget.exe'
