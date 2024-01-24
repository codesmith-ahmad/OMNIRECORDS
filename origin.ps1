
# Set the origin point of this workspace
$origin = "C:\OMNIRECORDS"  # Define origin
Set-Location $origin


# SCRIPTS

. ".\Scripts\loadConfigJSON"      # Load config settings from JSON
. ".\Scripts\UISettings"          # Set UI settings
. ".\Scripts\importModules"       # Import modules
. ".\Scripts\importFunctions.ps1" # Import functions
. ".\Scripts\welcome.ps1"         # Welcome user
. ".\Scripts\updateDB"            # Update OMNIRECORDS