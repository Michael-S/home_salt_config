<#
Script to run the UserRights.ps1 script
and use it to make sure the account
with name (in environment variable)
$env:adminuser
has the desired privileges.

#>

echo "Importing module"
Import-Module C:\Windows\Temp\UserRights.ps1
$desiredprivileges = @("seTakeOwnershipPrivilege", "SeRestorePrivilege", "SeBackupPrivilege")
echo "Getting privileges for $env:adminuser"
$actualprivilegescontainer = Get-UserRightsGrantedToAccount $env:adminuser
$actualprivilegescontainer | ForEach {
  echo "Have item: $_"
}
echo "Trying select-object"
$actualprivileges = $actualprivilegescontainer.Right
echo "Have actual privileges $actualprivileges"


$desiredprivileges | ForEach {
   $privilege = $_
   $hasprivilege = $actualprivileges -contains $privilege
   if (-not $hasprivilege) {
       echo "Granting $env:adminuser right $privilege"
       Grant-UserRight -Account $env:adminuser -Right $privilege
   } else {
       echo "$env:adminuser already has right $privilege"
   }
}
