#!/usr/bin/env pwsh

$hostnameFile = "C:\Users\ChenPi11\AppData\Roaming\tor\torrc"

while (-not (Test-Path $hostnameFile))
{
    Write-Host "Waiting for file $hostnameFile ..."
    Start-Sleep -Seconds 3
}

Write-Host "====================================="
Get-Content -Path $hostnameFile
Write-Host "====================================="
