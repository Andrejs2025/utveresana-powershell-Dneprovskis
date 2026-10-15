$warningLimitGB = 20
$disks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

foreach ($d in $disks) {
    $freeGB = [Math]::Round($d.FreeSpace / 1GB, 2)
    $totalGB = [Math]::Round($d.Size / 1GB, 2)

    Write-Output "Disks: $($d.DeviceId) | Kopā: $totalGB GB | Brīvs: $freeGB GB"

    if ($freeGB -lt $warningLimitGB) {
        Write-Output "BRĪDINĀJUMS: Uz diska $($d.DeviceId) ir mazāk par $warningLimitGB GB brīvas vietas!"
    }
}