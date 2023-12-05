# Set the path to the folder containing the .ps1 files
$folderPath = "C:\OMNIRECORDS\Functions"

# Get a list of .ps1 files in the folder
$scriptFiles = Get-ChildItem -Path $folderPath -Filter "*.ps1"

# Iterate through each .ps1 file and run it
foreach ($scriptFile in $scriptFiles) {
    Write-Host "${c}Running $($scriptFile.Name)...${0}"
    
    # Dot source the script to run its contents in the current session
    . $scriptFile.FullName

    Write-Host "${bc}$($scriptFile.Name) completed.${0}"
}
