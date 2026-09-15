function Assert-CommandExists
{
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue))
    {
        Write-Error "Error: '$Name' is not installed"
        exit 1
    }
}
