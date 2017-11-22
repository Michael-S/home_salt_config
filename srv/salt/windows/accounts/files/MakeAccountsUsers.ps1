
$group = [ADSI]"WinNT://./Users,group"
#echo "Group $group has members $group.members"
#$group | Select-Object
#$group.add("WinNT://$env:usertomanage,user")
