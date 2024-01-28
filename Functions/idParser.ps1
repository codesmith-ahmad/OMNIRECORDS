# TESTED

# Parses the id string for update.ps1
# And returns an array of [letters,number]

function idParser {
    param (
        [string]$inputString
    )

    # Use a regular expression to match the letters and numbers
    $match = $inputString -match '^([a-zA-Z]{1,4})(\d{1,3})$'

    if ($match) {
        $letters = $matches[1]
        $number = [int]$matches[2]

        # Output the parsed values
        return ($letters,$number)
    }
    else {
        Write-Host "`e[7m`e[31mInvalid format`e[0m"
        return (0,'error')
    }
}