# Windows Defender Restore Tool

This repository restores the Windows Defender service (`WinDefend`) on Windows systems where it was manually removed or stripped out.

## Includes

- `winDefend.reg`: Registry export of the Defender service key
- `restore-defender.ps1`: PowerShell script to import registry, recreate the service, and start it

## Instructions

1. Clone or download this repo
2. Run PowerShell as Administrator
3. Execute the script:

```powershell
.\restore-defender.ps1
