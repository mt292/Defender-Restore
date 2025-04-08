Write-Host "[*] Restoring Windows Defender..." -ForegroundColor Cyan

# Step 1: Import Defender service registry key
$regFile = Join-Path $PSScriptRoot "winDefend.reg"
if (Test-Path $regFile) {
    Write-Host "[+] Importing registry key from winDefend.reg"
    reg import $regFile
} else {
    Write-Host "[-] Registry file not found!" -ForegroundColor Red
    exit 1
}

# Step 2: Recreate the Defender service
Write-Host "[+] Attempting to recreate WinDefend service..."
sc.exe create WinDefend binPath= "C:\Program Files\Windows Defender\MsMpEng.exe" start= auto

# Step 3: Start the service
Write-Host "[+] Starting Defender service..."
Start-Service -Name WinDefend -ErrorAction SilentlyContinue

# Step 4: Check status
$svc = Get-Service -Name WinDefend -ErrorAction SilentlyContinue
if ($svc.Status -eq 'Running') {
    Write-Host "[✔] Defender service is running." -ForegroundColor Green
} else {
    Write-Host "[!] Defender service did not start. Check binary path or logs." -ForegroundColor Yellow
}

Write-Host "[*] Done." -ForegroundColor Cyan
