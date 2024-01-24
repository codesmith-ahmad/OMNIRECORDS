# Load config settings
$configFilePath = ".\config.json"                      # Path of config.json file
$jsonContent = Get-Content -Path $configFilePath -Raw  # Read the content of the JSON file
$config = $jsonContent | ConvertFrom-Json -AsHashtable # Can access properties like $config.PropertyKey