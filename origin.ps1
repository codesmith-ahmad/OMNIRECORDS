
function launch {
    param (
        [string]$inputString
    )

    if ($inputString -eq "omnirecords") {
        . ".\launchOmnirecords.ps1"
    }
    else {
        write-host "Omnirecords is the only option for now"
    }
}