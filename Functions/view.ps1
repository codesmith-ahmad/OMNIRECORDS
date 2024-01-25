
# TODO : FOR FUNCTION view, INCLUDE SECOND AND THIRD ARGUMENT FOR "WHERE" STATEMENT:

# Routing function for the most used tables
function view ($table, $wrapSignal){
    if (-not $table){<#prompt for table#>}
    $table = $table.ToLower()
    if ($table -eq "archives")    {viewArchives $wrapSignal}
    if ($table -eq "assignments") {viewAssignments $wrapSignal}
    if ($table -eq "courses")     {sql 'select * from courses_info' -t}
    if ($table -eq "expenses")    {viewExpenses $wrapSignal}
    if ($table -eq "passwords")   {viewPasswords $wrapSignal}
    if ($table -eq "tasks")       {viewTasks $wrapSignal} 
}

function viewArchives ($wrapSignal) {
    $archives = (sql 'select * from Archives')

    Write-Host "`n`e[7m`e[4m`e[32mARCHIVES`e[27m`e[0m"
    if (-not ($wrapSignal)){$archives | Format-Table}
    else {$archives | Format-Table -wrap}

    Write-Host "`n`e[3m`e[93mTo archive something: `e[4m`e[92marchive [filepath]`e[24m`e[93m`e[0m`n"
}

function viewAssignments ($wrapSignal) {
    $assignments = (sql 'select * from AssignmentsView')
    $urgencyLevel = @{
        low = 7
        med = 4
        high = 2
    }

    foreach ($row in $assignments){
        #status
        if ($row.status -eq "not started"){$row.status = "`e[31m" + $row.status + "`e[0m"}
        elseif ($row.status -eq "in progress"){$row.status = "`e[93m" + $row.status + "`e[0m"}
        elseif ($row.status -eq "done")       {$row.status = "`e[92m" + $row.status + "`e[0m"}
        #lifetime
        if ($row.lifetime -le $urgencyLevel.high){
            $row.lifetime = "`e[41m`e[97m   " + $row.lifetime + "   `e[0m"
            $row.description = "`e[5m" + $row.description + "`e[0m"
            $row.id = "`e[5m" + $row.id + "`e[0m"
        }
        elseif ($row.lifetime -le $urgencyLevel.med) {$row.lifetime = "`e[103m`e[30m   " + $row.lifetime + "   `e[0m"}
        elseif ($row.lifetime -le $urgencyLevel.low) {$row.lifetime = "`e[92m   " + $row.lifetime + "   `e[0m"}
    }

    Write-Host "`n`e[7m`e[4m`e[32mASSIGNMENTS`e[27m`e[0m"
    if (-not ($wrapSignal)){$assignments | Format-Table}
    else {$assignments| Format-Table -wrap}

    # Write-Host "`n`e[3m`e[93mActions:\n`e[0m"
    $b = Read-Host @"
${yellow}[1] Go to assignments folder
[2] Go to Brightspace
[ ] Skip

>>>>>>$0d 
"@

    if ($b -eq 1){saps "C:\Users\Ahmad\OneDrive\ASSIGNMENTS"}
    if ($b -eq 2){saps "https://brightspace.algonquincollege.com/d2l/home"}
}

function viewExpenses ($wrapSignal){

    $x = (sql 'select * from ExpensesView')
    $z = (sql 'select * from ExpensesViewAggr')
        $z.bill = "`e[7m`e[25m" + $z.bill + "`e[0m"
        $z.monthly = "`e[93m" + [math]::Round($z.monthly,2) + "`$`e[0m"
        $z.weekly = "`e[93m" + [math]::Round($z.weekly,2) + "`$`e[0m"
        $z.daily = "`e[93m" + [math]::Round($z.daily,2) + "`$`e[0m"
        $z.note = "`e[2m`e[3m" + $z.note + "`e[0m"
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
    if (-not ($wrapSignal)){$x | Format-Table}
    else {$x | Format-Table -wrap}

    Write-Host "`n`e[3m`e[93mTO MAKE PAYMENT: `e[4m`e[92mupdate ID`e[24m`e[93m, replace ID by Expenses.id`e[0m`n"
}

function viewPasswords ($wrapSignal){
    $key = Get-Content (sql 'select * from addresses where key = "aes_key"').filepath # fetch 16-byte key
    $cred = sql 'select * from CredentialsView' # fetch table
    foreach ($row in $cred){$row.pass = "`e[93m" + (decrypt $row.pass $key) + "`e[0m"} # convert each cipher to text

    Write-Host "`n`e[7m`e[4m`e[32mPASSWORDS`e[27m`e[0m"
    if (-not ($wrapSignal)){$cred | Format-Table}
    else {$cred | Format-Table -wrap}
}

function viewTasks ($wrapSignal){
    $tasks = (sql 'select * from TaskView')
    $urgencyLevel = @{
        low = 7
        med = 4
        high = 2
    }

    foreach ($row in $tasks){
        #priority
        if ($row.priority -eq 'CRITICAL'){$row.priority = "`e[31m" + $row.priority + "`e[0m"}
        #status
        if ($row.status -eq "not started"){$row.status = "`e[31m" + $row.status + "`e[0m"}
        elseif ($row.status -eq "in progress"){$row.status = "`e[93m" + $row.status + "`e[0m"}
        elseif ($row.status -eq "done")       {$row.status = "`e[92m" + $row.status + "`e[0m"}
        #time_left
        if ($row.time_left -le $urgencyLevel.high){
            $row.time_left = "`e[41m`e[97m   " + $row.time_left + "   `e[0m"
            $row.task = "`e[5m" + $row.task + "`e[0m"
            $row.id = "`e[5m" + $row.id + "`e[0m"
        }
        elseif ($row.time_left -le $urgencyLevel.med) {$row.time_left = "`e[103m`e[30m   " + $row.time_left + "   `e[0m"}
        elseif ($row.time_left -le $urgencyLevel.low) {$row.time_left = "`e[92m   " + $row.time_left + "   `e[0m"}
    }

    Write-Host "`n`e[7m`e[4m`e[32mTASKS`e[27m`e[0m"
    if (-not ($wrapSignal)){$tasks | Format-Table}
    else {$tasks | Format-Table -wrap}

    # Write-Host "`n`e[3m`e[93mActions:\n`e[0m"
}