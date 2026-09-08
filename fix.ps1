. "$PSScriptRoot\Assert-CommandExists.ps1"

$ErrorActionPreference = "Stop"

Assert-CommandExists -Name "dart"

& "$PSScriptRoot\analyze.ps1"

dart fix --apply
