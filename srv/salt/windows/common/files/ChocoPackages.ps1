<#
Make sure the Chocolatey packages we expect
are installed and up to date.
#>

$packages = @("jdk8", "firefox", "googlechrome", "vlc", "steam", "notepadplusplus", "libreoffice", "kodi")
foreach ($package in $packages) {
   $packagepattern = $package + ".*"
   if (-not ((choco list --local-only) | select-string -pattern $packagepattern -Quiet)) {
       choco install $package --yes
   } else {
       choco upgrade $package --yes
   }
}



