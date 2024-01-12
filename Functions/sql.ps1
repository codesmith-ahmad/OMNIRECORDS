# Shorthand for invoke-sqlitequery -datasource "$origin\omnirecords.db" -Query

function sql {
    [CmdletBinding()]
    param (
        [String]$query,
        [switch]$t
    )

    #$query = $args -join " "
    $result = invoke-sqlitequery -datasource $config.database -Query $query
    if ($t){return $result | Format-Table}
    else   {return $result}
}