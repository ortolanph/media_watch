. "$PSScriptRoot\Assert-CommandExists.ps1"

$ErrorActionPreference = "Stop"

Assert-CommandExists -Name "flutter"
Assert-CommandExists -Name "dart"

& "$PSScriptRoot\compile.ps1"

flutter build web --base-href /tvshows/
