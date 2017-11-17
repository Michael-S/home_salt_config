echo Changing file locations for "$env:movedusername"
. G:\userdata\Set-KnownFolderPath.ps1
$array = "Desktop","Documents","Videos","Downloads","Pictures","Music"
ForEach ($value in $array) {
   mkdir "G:\userdata\$env:movedusername\$value"
   Set-KnownFolderPath -KnownFolder $value "G:\userdata\$env:movedusername\$value"
}
