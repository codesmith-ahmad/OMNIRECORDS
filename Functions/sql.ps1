# Shorthand for invoke-sqlitequery -datasource "$origin\omnirecords.db" -Query

function sql {
    $query = $args -join " "
    $result = invoke-sqlitequery -datasource $config.database -Query $query
    return $result
}