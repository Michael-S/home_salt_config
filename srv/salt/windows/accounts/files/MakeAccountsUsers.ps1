<#
Checks if the user in environment variable 'usertomanage' is in the Users group.
If the accout is already in the group, it just prints a message.
Otherwise, it adds the user to the group.

The two lines with 'StackOverflow-Goyuix' above are taken from
https://stackoverflow.com/questions/13929960/add-user-to-local-group#14262326
by StackOverflow user 'Goyuix'.
Per StackOverflow, all user contributions are under a Creative Commons 
Attribution-Share Alike Unported license ( https://creativecommons.org/licenses/by-sa/3.0/ )

The line starting with Petri-Jeff Hicks are taken from
https://www.petri.com/use-powershell-to-find-local-groups-and-members
from site contributor Jeff Hicks.
It's not clear what license that content is under, and in fact I may need to
remove it.  I sent an email to Jeff Hicks asking for permission. 

 
#>

# Stackoverflow-Goyuix
$group = [ADSI]"WinNT://./Users,group"
#echo "Group $group has members $group.members"
# Petri-Jeff Hicks
$members = $group.psbase.Invoke("Members")
$found = $false
$names = $members | ForEach-Object {
   # Petri-Jeff Hicks
   $_.GetType.Invoke().InvokeMember("Name", 'GetProperty', $null, $_, $null)
}
#echo $names
if ($names -contains $env:usertomanage) {
  echo "Found $env:usertomanage in group already."
} else {
  # StackOverflow-Goyuix
  $group.add("WinNT://$env:usertomanage,user")
  echo "Added $env:usertomanage to the Users group."
}
