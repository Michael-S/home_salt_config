
$group = [ADSI]"WinNT://./Users,group"
#echo "Group $group has members $group.members"
$members = $group.psbase.Invoke("Members")
$found = $false
$names = $members | ForEach-Object {
   $_.GetType.Invoke().InvokeMember("Name", 'GetProperty', $null, $_, $null)
}
#echo $names
if ($names -contains $env:usertomanage) {
  echo "Found $env:usertomanage in group already."
} else {
  $group.add("WinNT://$env:usertomanage,user")
  echo "Added $env:usertomanage to the Users group."
}
