#!/usr/bin/env pwsh

Set-Location tor
$torJob = .\tor\tor.exe -f $pwd/../torrc.win &
Set-Location ..
$codeServerJob = npx code-server &

$hostnameFile = "D:\tmp\hidden_service\hostname"

while (-not (Test-Path $hostnameFile)) {
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
            echo "BREAK!"
            break
        }

        Start-Sleep -Seconds 1
    }
    echo "EXIT!!!"
}
finally {
    Write-Host "========================== exit =========================="
    Get-Job | Stop-Job | Remove-Job
}
