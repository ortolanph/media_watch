. "$PSScriptRoot\Assert-CommandExists.ps1"

$ErrorActionPreference = "Stop"

Assert-CommandExists -Name "flutter"
Assert-CommandExists -Name "dart"

& "$PSScriptRoot\clean.ps1"
& "$PSScriptRoot\dependencies.ps1"

dart run build_runner build -d
