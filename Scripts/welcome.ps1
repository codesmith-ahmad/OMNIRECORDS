# pause

# Display banner
Clear-Host
. "$origin\Scripts\displayBanner"

# Display datetime
$date = get-date -format "dddd, MMMM d, yyyy"
$time = get-date -format "hh:mm tt"
write-host "`nTODAY IS:" (fgo (u $date)) (f (fgg $time)) "`n"

$Host.UI.RawUI.ForegroundColor = $config.consoleSettings.foregroundColor