<#
Single hashes are single line comment starts in powershell
# this is a comment
and contents inside less than plus hash all of the way through
hash then greater than are a multi-line comment.

I found this script on
https://blog.jourdant.me/post/3-ways-to-download-files-with-powershell
and per the page, the content is released under this license:
https://creativecommons.org/licenses/by-sa/4.0/

I *believe* that makes it fair game for me to use it here.
#>
$url=$args[0]
$output=$args[1]

$start_time = Get-Date

Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

