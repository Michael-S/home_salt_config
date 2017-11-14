# Make sure our accounts exist.

# This code is taken from https://stackoverflow.com/questions/11121421/testing-if-a-user-exist-locally-always-return-false#11121699
# by 'Steve B' and 'CB.' and assumed to be under a CC-BY-SA-4.0 license.
$objOu = [ADSI]"WinNT://${env:Computername}"
$localUsers = $objOu.Children | where {$_.SchemaClassName -eq 'user'}  | % {$_.name[0].ToString()}

$localUsers
# still don't have the syntax right...
# echo $localUsers | select-string -pattern "{{ pillar['windowsusername1'] }}" -Quiet


