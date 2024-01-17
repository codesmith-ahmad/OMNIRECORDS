function Open-Image {
    param (
        [byte[]]$ImageBytes
        )

    try {
        $tempFilePath = [System.IO.Path]::GetTempFileName() + ".jpg"
        [System.IO.File]::WriteAllBytes($tempFilePath, $ImageBytes)
        Start-Process $tempFilePath
    }
    catch {
        Write-Host "Error opening the image: $_"
    }
}