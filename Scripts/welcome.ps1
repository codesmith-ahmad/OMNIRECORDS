# pause  #todo FOR DEBUGGING

# Display banner
Clear-Host
. ".\Scripts\displayBanner"

# Display datetime
$date = get-date -format "dddd, MMMM d, yyyy"
$time = get-date -format "hh:mm tt"
write-host "`nTODAY IS:" (fgo (u $date)) (f (fgg $time))

# Display database
Write-Host "`nCurrent database: OMNIRECORDS ($($config.database))`n"

$Host.UI.RawUI.ForegroundColor = $config.consoleSettings.foregroundColor