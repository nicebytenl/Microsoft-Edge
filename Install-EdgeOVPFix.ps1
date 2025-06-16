# Jordy Smits - 16-06-2025
# This script checks for the 'ovp' registry value and runs the 'cmd' fix if present.
# Logs actions to C:\Temp\EdgeOVPFix.log. Exit code 0 = success, 1 = error.

$logFile = "C:\Temp\EdgeOVPFix.log"

# Ensure C:\Temp exists
if (-not (Test-Path -Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory -Force | Out-Null
}

function Write-Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $message"
}

Write-Log "=== Starting Edge OVP Fix ==="

$regPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"

try {
    # Check for 'ovp' registry value
    $ovpValue = Get-ItemProperty -Path $regPath -Name "ovp" -ErrorAction Stop
    Write-Log "'ovp' registry value found."

    # Read and validate 'cmd' value
    $cmdValue = (Get-ItemProperty -Path $regPath -Name "cmd" -ErrorAction Stop).cmd

    if ([string]::IsNullOrWhiteSpace($cmdValue)) {
        Write-Log "ERROR: 'cmd' value is missing or empty."
        exit 1
    }

    Write-Log "Executing: $cmdValue"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$cmdValue`"" -Wait -NoNewWindow
    Write-Log "Command executed successfully."

} catch {
    Write-Log "No action taken or error occurred: $_"
}

Write-Log "=== Script finished ===`n"
exit 0
