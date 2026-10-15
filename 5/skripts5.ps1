$timeLimit = (Get-Date).AddHours(-48)
$errors = Get-WinEvent -FilterHashtable @{LogName='System'; Level=2; StartTime=$timeLimit}
$errorCount = ($errors | Measure-Object).Count

$topSource = $errors | Group-Object ProviderName | Sort-Object Count -Descending | Select-Object -First 1

Write-Output "Kļūdu skaits pēdējo 48 stundu laikā: $errorCount"
Write-Output "Visbiežākais avots: $($topSource.Name) (skaits: $($topSource.Count))"