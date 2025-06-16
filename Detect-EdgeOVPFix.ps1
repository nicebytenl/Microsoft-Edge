# Jordy Smits - 16-06-2025
# This script checks if the 'opv' registry value still exists. If it does, detection fails. If not, detection passes.

$regPath = "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"

try {
# Attempt to get the 'opv' registry value
$opv = Get-ItemProperty -Path $regPath -Name "opv" -ErrorAction Stop

# If 'opv' exists, detection fails (exit code 1)
Write-Output "'ovp' registry value is still present: $opv"
} catch {
# If 'opv' does not exist, detection is successful (exit code 0)
Write-Output "'opv' registry value not found. No action required"
}
