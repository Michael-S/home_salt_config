# This is adapted from https://mcpmag.com/articles/2015/06/18/reporting-on-local-groups.aspx


$Computer = $env:COMPUTERNAME
#echo Computer:
#$Computer
$ADSIComputer = [ADSI]("WinNT://$Computer,computer") 
#echo ADSIComputer:
#$ADSIComputer
$group = $ADSIComputer.psbase.children.find('Administrators',  'Group') 
#echo Administrator group:
#$group
$adminaccounts = $group.psbase.invoke("members")  | ForEach{

  $_.GetType.Invoke().InvokeMember("Name",  'GetProperty',  $null,  $_, $null)

} 

#echo Adminaccounts:
#$adminaccounts

#echo is shouldbeusername in adminaccounts? 
$alreadyadmin = $adminaccounts -contains $env:shouldbeadminusername
#echo Is $env:shouldbeadminusername already admin? $alreadyadmin
if ($alreadyadmin) {
  echo $env:shouldbeadminusername is already an administrator.
} else {
$group.add("WinNT://$Computer/$env:shouldbeadminusername,user")
  echo $env:shouldbeadminusername added to administrators.
}

echo Admin accounts are $adminaccounts

echo Salt is running as: $env
