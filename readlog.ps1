#!/usr/bin/env pwsh

Set-Location tor
$torJob = .\tor\tor.exe &
Set-Location ..
$codeServerJob = npx code-server &

$hostnameFile = "C:\Users\ChenPi11\AppData\Roaming\tor\hidden_service\hostname"

while (-not (Test-Path $hostnameFile))
{
    Write-Host "Waiting for file $hostnameFile ..."
    Start-Sleep -Seconds 3
}

Write-Host "====================================="
Get-Content -Path $hostnameFile
Write-Host "====================================="

try {
    while ($true) {
        $torOutput = Receive-Job -Job $torJob
        if ($torOutput) {
            $torOutput = $torOutput | Out-String
            Write-Host "========================== Tor =========================="
            Write-Host $torOutput
        }

        $codeServerOutput = Receive-Job -Job $codeServerJob
        if ($codeServerOutput) {
            $codeServerOutput = $codeServerOutput | Out-String
            Write-Host "========================== code-server =========================="
            Write-Host $codeServerOutput
        }

        if ($torJob.State -eq 'Completed' -and $codeServerJob.State -eq 'Completed') {
            break
        }

        Start-Sleep -Seconds 5
    }
}
finally {
    Write-Host "========================== exit =========================="
    Get-Job | Stop-Job | Remove-Job
}
