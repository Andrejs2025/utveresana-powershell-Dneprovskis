$services = Get-CimInstance -ClassName Win32_Service | Where-Object {$_.StartMode -eq 'Auto' -and $_.State -eq 'Stopped'}
$count = ($services | Measure-Object).Count

if ($count -eq 0) {
    Write-Output "Atrasto servisu skaits: 0"
} else {
    Write-Output "Atrasti servisi ($count):"
    $services | Select-Object Name, DisplayName
}