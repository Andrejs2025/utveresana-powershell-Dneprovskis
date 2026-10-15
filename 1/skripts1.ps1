$os = Get-CimInstance -ClassName Win32_OperatingSystem
$psVersion = $PSVersionTable.PSVersion
$processes = Get-Process

Write-Output "Datora nosaukums: $env:COMPUTERNAME"
Write-Output "Operētājsistēma: $($os.Caption) (Būvējums: $($os.BuildNumber))"
Write-Output "PowerShell versija: $psVersion"
Write-Output "Pašreizējais datums un laiks: $(Get-Date)"
Write-Output "Aktīvo procesu skaits: $($processes.Count)"