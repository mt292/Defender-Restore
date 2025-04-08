Write-Host "[*] Restoring Windows Defender..." -ForegroundColor Cyan

$regFile = Join-Path $PSScriptRoot "winDefend.reg"
if (Test-Path $regFile) {
    Write-Host "[+] Importing registry key from winDefend.reg"
    reg import $regFile
} else {
    Write-Host "[-] Registry file not found!" -ForegroundColor Red
    exit 1
}

Write-Host "[+] Attempting to recreate WinDefend service..."
sc.exe create WinDefend binPath= "C:\Program Files\Windows Defender\MsMpEng.exe" start= auto

Write-Host "[+] Starting Defender service..."
Start-Service -Name WinDefend -ErrorAction SilentlyContinue

$svc = Get-Service -Name WinDefend -ErrorAction SilentlyContinue
if ($svc.Status -eq 'Running') {
    Write-Host "[✔] Defender service is running." -ForegroundColor Green
} else {
    Write-Host "[!] Defender service did not start. Check binary path or logs." -ForegroundColor Yellow
}

Write-Host "[*] Done." -ForegroundColor Cyan
