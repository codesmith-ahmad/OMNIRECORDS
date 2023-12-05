
# Set the origin point of this workspace
$origin = "C:\OMNIRECORDS"  # Define origin
Set-Location $origin

# Load config settings
$configFilePath = "$origin\config.json"                # Path of config.json file
$jsonContent = Get-Content -Path $configFilePath -Raw  # Read the content of the JSON file
$config = $jsonContent | ConvertFrom-Json -AsHashtable # Can access properties like $config.PropertyKey

# Set UI settings
$Host.UI.RawUI.WindowTitle = $config.consoleSettings.windowTitle
$Host.UI.RawUI.BackgroundColor = $config.consoleSettings.backgroundColor
$Host.UI.RawUI.ForegroundColor = $config.consoleSettings.foregroundColor

# Import modules
. "$origin\Scripts\importModules"

# Import functions
. "$origin\Scripts\importFunctions.ps1"

# Welcome user
. .\Scripts\welcome.ps1