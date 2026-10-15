$procCount = (Get-Process | Measure-Object).Count

$services = Get-Service
$runCount = ($services | Where-Object {$_.Status -eq 'Running'} | Measure-Object).Count
$stopCount = ($services | Where-Object {$_.Status -eq 'Stopped'} | Measure-Object).Count

$errCount = (Get-WinEvent -FilterHashtable @{LogName='System'; Level=2; StartTime=(Get-Date).AddHours(-48)} -ErrorAction SilentlyContinue | Measure-Object).Count

$disk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskFree = [Math]::Round($disk.FreeSpace / 1GB, 2)

Write-Output "1. Procesu skaits tagad: $procCount"
Write-Output "3. Strādājoši servisi: $runCount | Apturēti servisi: $stopCount"
Write-Output "5. Kļūdu skaits žurnālā: $errCount"
Write-Output "7. Brīvā vieta uz C: diska: $diskFree GB"