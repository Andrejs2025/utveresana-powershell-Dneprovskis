Get-Process | ForEach-Object {
    try {
        $owner = $_ | Get-ProcessOwner -ErrorAction Stop
        [PSCustomObject]@{
            ProcessName = $_.Name
            Id          = $_.Id
            User        = $owner.User
        }
    } catch {
        [PSCustomObject]@{
            ProcessName = $_.Name
            Id          = $_.Id
            User        = "Nav tiesību / Nav pieejams"
        }
    }
}