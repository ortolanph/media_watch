. "$PSScriptRoot\Assert-CommandExists.ps1"

Write-Host "---=== Docker Build ===---"

$imageName = "media_watch"

Assert-CommandExists -Name "docker"

docker image inspect "${imageName}:old" 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Removing ${imageName}:old..."
    docker rmi "${imageName}:old"
}

docker image inspect "${imageName}:latest" 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Tagging ${imageName}:latest as old..."
    docker tag "${imageName}:latest" "${imageName}:old"
}

Write-Host "--- Docker Build ---"
docker build -t "${imageName}:latest" .
