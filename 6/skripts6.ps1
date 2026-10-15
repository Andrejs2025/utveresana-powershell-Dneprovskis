$drivers = Get-CimInstance -ClassName Win32_PnPSignedDriver | Where-Object {$_.Manufacturer -ne 'Microsoft'}
$drivers | Select-Object DeviceName, Manufacturer, DriverVersion | Export-Csv -Path "drivers.csv" -NoTypeInformation -Encoding utf8

$csvLines = (Import-Csv -Path "drivers.csv").Count
Write-Output "CSV failā ir $csvLines rindas."