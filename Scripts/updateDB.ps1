# To make sure I don't forget to pull before I sync
# To automate tasks using SQLite by updating datetime when launching Powershell

git pull
Write-Host ""

sql @"
UPDATE _timestamp SET
    unix = (SELECT strftime('%s', 'now')),
    julian = (SELECT julianday('now')),
    iso8601 = (SELECT datetime('now'))
"@