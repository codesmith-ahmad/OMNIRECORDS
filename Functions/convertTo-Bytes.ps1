function convertto-bytes {
    param (
        [string]$FilePath
    )

    try {
        return [System.IO.File]::ReadAllBytes($FilePath)
    }
    catch {
        Write-Host "Error reading bytes from file: $_"
        return $null
    }
}