$services = Get-Service
$runningCount = 0
$stoppedCount = 0

foreach ($s in $services) {
    if ($s.Status -eq 'Running') {
        $runningCount++
    }
    elseif ($s.Status -eq 'Stopped') {
        $stoppedCount++
    }
}

$total = $runningCount + $stoppedCount
Write-Output "Strādājoši servisi: $runningCount"
Write-Output "Apturēti servisi: $stoppedCount"
Write-Output "Kopējā summa: $total"