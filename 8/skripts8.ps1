$time1 = Measure-Command {
    Get-Service -Name Spooler
}

$time2 = Measure-Command {
    Get-CimInstance -ClassName Win32_Service -Filter "Name='Spooler'"
}

Write-Output "1. veida izpildes laiks (Get-Service): $($time1.TotalMilliseconds) ms"
Write-Output "2. veida izpildes laiks (Get-CimInstance): $($time2.TotalMilliseconds) ms"