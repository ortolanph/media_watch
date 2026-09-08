. "$PSScriptRoot\Assert-CommandExists.ps1"

$ErrorActionPreference = "Stop"

Assert-CommandExists -Name "dart"

dart analyze
