
$gdriveuserdataexists = Test-Path G:\userdata
if (-not $gdriveuserdataexists) {
    New-Item -ItemType Directory -Force -Path G:\userdata
    echo "G:\userdata created."
} else {
    echo "G:\userdata already exists."
}
