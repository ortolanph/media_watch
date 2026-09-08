. "$PSScriptRoot\Assert-CommandExists.ps1"

Assert-CommandExists -Name "docker"

docker run -d -p 8080:80 --name media_watch_application media_watch:latest
