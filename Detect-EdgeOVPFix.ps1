# Jordy Smits - 16-06-2025
# This script checks for the existence of the 'opv' registry key.
# If found, it reads and executes the corresponding 'cmd' value from the same registry path.

$regPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"

# Check if 'opv' registry value exists
$ovpValue = Get-ItemProperty -Path $regPath -Name "opv" -ErrorAction SilentlyContinue

if ($ovpValue) {
    # Read the 'cmd' value, which contains the full setup command
    $cmdValue = (Get-ItemProperty -Path $regPath -Name "cmd" -ErrorAction SilentlyContinue).cmd

    if ($cmdValue) {
        Write-Output "Executing Edge fix command from registry: $cmdValue"

        # Start the process using the exact command stored in the registry
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$cmdValue`"" -Wait -NoNewWindow
    } else {
        Write-Warning "'cmd' registry value not found, unable to continue."
    }
} else {
    Write-Output "No 'ovp' registry value found. No action required."
}
