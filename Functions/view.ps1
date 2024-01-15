
# TODO : FOR FUNCTION view, INCLUDE SECOND AND THIRD ARGUMENT FOR "WHERE" STATEMENT:
<#
    view assignments deadline (date).tostring("yyyy-MM-dd")
    >> $table = 'assignments'
    >>   $key = 'deadline'
    >> $value = '2024-01-12'
    >> $whereClause = "WHERE $key = `'$value`'"
    >>       $query = $query + $whereClause
#>

# Routing function
function view ($table){
    if (-not $table){<#prompt for table#>}
    $table = $table.ToLower()
    if ($table -eq "archives")    {viewArchives}
    if ($table -eq "assignments") {viewAssignments}
    if ($table -eq "expenses")    {viewExpenses}
}

function viewArchives {
    $archives = (sql 'select * from Archives')
    foreach ($row in $archives){
        $row.Documents = "" + $config.database + "\..\" + $row.Documents
    }

    Write-Host "`n`e[7m`e[4m`e[32mARCHIVES`e[27m`e[0m"
    $archives | Format-Table

    Write-Host "`n`e[3m`e[93mTo archive something: `e[4m`e[92marchive [filepath]`e[24m`e[93m`e[0m`n"
}

function viewAssignments {
    $assignments = (sql 'select * from Assignments')
    foreach ($row in $assignments){
        if ($row.status -eq "not started"){$row.status = "`e[31m" + $row.status + "`e[0m"}
        if ($row.status -eq "in progress"){$row.status = "`e[93m" + $row.status + "`e[0m"}
        if ($row.status -eq "done")       {$row.status = "`e[92m" + $row.status + "`e[0m"}
    }

    Write-Host "`n`e[7m`e[4m`e[32mASSIGNMENTS`e[27m`e[0m"
    $assignments | Format-Table

    Write-Host "`n`e[3m`e[93mTo do action: `e[4m`e[92mcommand [arg]`e[24m`e[93m`e[0m`n"
}

function viewExpenses {

    $x = (sql 'select * from ExpensesView')
    $z = (sql 'select * from ExpensesViewAggr')
        $z.bill = "`e[7m`e[25m" + $z.bill + "`e[0m"
        $z.monthly = "`e[93m" + [math]::Round($z.monthly,2) + "`$`e[0m"
        $z.weekly = "`e[93m" + [math]::Round($z.weekly,2) + "`$`e[0m"
        $z.daily = "`e[93m" + [math]::Round($z.daily,2) + "`$`e[0m"
        $z.note = "`e[2m`e[3m$z.note`e[0m"
    $x = $x + $z

    foreach ($row in $x){
        $row.deadline = (Get-date $row.deadline -format "MMM d").toUpper()

        $y = $row.remaining
        $row.remaining = [math]::Round($y)
        if ($y -le 0){
            $row.remaining = "`e[5m`e[31m" + $row.remaining  # Apply blink AND red
            $row.id = "`e[5m" + $row.id + "`e[0m"        # Flash id
            $row.bill = "`e[5m" + $row.bill + "`e[0m"    # Flash bill name
        }
        elseif ($y -le 3){$row.remaining = "`e[31m" + $row.remaining} # Apply red
        elseif ($y -le 5){$row.remaining = "`e[91m" + $row.remaining} # Apply bright red
        elseif ($y -le 7){$row.remaining = "`e[93m" + $row.remaining} # Apply yellow
        
        $row.remaining = "" + $row.remaining + " days`e[0m"

        if ($row.isPaid -eq $false){$row.isPaid = "`e[31mfalse`e[0m"}
        if ($row.isPaid -eq $true) {$row.isPaid = "`e[94mtrue`e[0m"}
    }

    Write-Host "`n`e[7m`e[4m`e[32mEXPENSES`e[27m`e[0m"
    $x | Format-Table

    Write-Host "`n`e[3m`e[93mTO MAKE PAYMENT: `e[4m`e[92mupdate ID`e[24m`e[93m, replace ID by Expenses.id`e[0m`n"
}