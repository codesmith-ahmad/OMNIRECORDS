
# TODO

# Routing function
function open-blob ($uniqueId){
    if (-not $id){<#prompt for table#>}
    $uniqueId = idParser($uniqueId.toLower())
    $tableCode = $uniqueId[0]
    $id = $uniqueId[1]
    if ($tableCode -eq "arch")  {"opening BLOB $id from archives ^_^"}
    elseif ($tableCode -eq "a") {"opening BLOB $id from assignments ^_^"}
    elseif ($tableCode -eq "e") {"opening BLOB $id from expenses ^_^"}
    else {"No such table code or id"}
}

function open {
    param (
        [byte[]]$blob,
        [string]$ext
        )

    try {
        $tempFilePath = [System.IO.Path]::GetTempFileName() + ".$ext"
        [System.IO.File]::WriteAllBytes($tempFilePath, $blob)
        Start-Process $tempFilePath
    }
    catch {
        Write-Host "Error opening the BLOB: $_"
    }
}