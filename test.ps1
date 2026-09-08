. "$PSScriptRoot\Assert-CommandExists.ps1"

$ErrorActionPreference = "Stop"

Assert-CommandExists -Name "flutter"

flutter test
