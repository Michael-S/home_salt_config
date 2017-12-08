echo "Changing file locations for $env:username"
. G:\userdata\Set-KnownFolderPath.ps1
$array = "Desktop","Documents","Videos","Downloads","Pictures","Music"
ForEach ($value in $array) {
   New-Item -ItemType Directory -Force -Path "G:\userdata\$env:username\$value"
   # throws a harmless error for Downloads... not worth fixing.
   Set-KnownFolderPath -KnownFolder $value "G:\userdata\$env:username\$value"
}
