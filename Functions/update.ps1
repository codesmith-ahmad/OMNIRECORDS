# Routing function
function update ($idString){
    if (-not $idString){Write-Host "`e[31mSPECIFY ID`e[0m"}
    else {
        $parsedID = idParser $idString
        if ($parsedID[0] -eq 0){Write-Output "break!" ; break}
        $table = $parsedID[0].ToLower()
        $id = $parsedID[1]
        if ($table -eq 'a'){updateAssignments $id}
        elseif ($table -eq 'c'){updateCredentials $id}
        elseif ($table -eq 'd'){updateDocuments $id}
        elseif ($table -eq 'e'){updateEvents $id}
        elseif ($table -eq 'i'){updateIncome $id}
        elseif ($table -eq 'l'){updateLoans $id}
        elseif ($table -eq 't'){updateTasks $id}
        elseif ($table -eq 'x'){updateExpenses $id}
        else {
            Write-Host "`e[31mNO TABLE ASSOCIATED WITH`e[0m `""$idString[0]"`""
            Write-Host @"
            `e[92mA: Assignments
            C: Credentials
            D: Documents
            E: Events
            I: Income
            L: Loans
            T: Tasks
            X: Expenses`e[0m
"@
        }
    }
}

function updateAssignments ($id) {
    Write-Host (fgo "************************TODO ASSIGNMNETS $id*********************")
}

function updateCredentials ($id) {
    Write-Host (fgo "************************TODO CREDENTIALS $id*********************")
}

function updateDocuments ($id) {
    Write-Host (fgo "************************TODO DOCS $id*********************")
}

function updateEvents ($id) {
    Write-Host (fgo "************************TODO EVENTS $id*********************")
}

function updateIncome ($id) {
    Write-Host (fgo "************************TODO INCOME $id*********************")
}


function updateLoans ($id) {
    Write-Host (fgo "************************TODO LOANS $id*********************")
}

function updateTasks ($id) {
    Write-Host (fgo "************************TODO TASKS $id*********************")
}
function updateExpenses ($id){
    <#
    If paid is 0,
        CONFIRM (24.75)$ has been paid to (Driver's License)? [Y] Yes [N] No:
        > Y
        (Set isPaid = 1 where id = 13)
        if not Y, break
    If paid is 1,
        Update deadline?  [Y] Yes [N] No:
        > Y
        1. Create copy of id = 13
        2. Insert copy in ExpensesLog
        3.
        if fUnit = M
            (Set Deadline = Deadline + fNumber * months where id = 13)
        if fUnit = D
            (Set Deadline = Deadline + fNumber * Days where id = 13)
        set isPaid = 0 where id = 13
    #>
    # Retrieve the expense with the given id
    $expense = sql "SELECT * FROM Expenses WHERE id = $id"

    if ($null -eq $expense) {
        Write-Host "Expense with id $id not found."
        return
    }

    backup # SAVEPOINT: USE [RESTORE] TO UNDO CHANGES ***************************************

    # Check if the expense is paid
    if ($expense.isPaid -eq 0) {
        $confirmPayment = Read-Host -Prompt "`e[93mCONFIRM `e[4m$($expense.Amount)`e[24m$ has been paid to `e[4m$($expense.Bill)`e[24m? `e[7m[Y]`e[27m Yes `e[7m[N]`e[27m No`e[0m"
        if ($confirmPayment.ToLower() -eq 'y') {
            # Update isPaid to 1
            sql "UPDATE Expenses SET isPaid = 1 WHERE id = $id;"
        }
        else {
            Write-Host "Payment not confirmed. Exiting."
            return
        }
    }
    elseif ($expense.isPaid -eq 1) {
        $updateDeadline = Read-Host -Prompt "`e[93mUpdate deadline? `e[7m[Y]`e[27m Yes `e[7m[N]`e[27m No`e[0m"
        if ($updateDeadline.ToLower() -eq 'y') {
            $years  = [int] ($expense.frequency / 100000)
            $months = [int] ($expense.frequency % 100000 / 1000)
            $days   = [int] ($expense.frequency % 1000)
            $date   = (Get-date $expense.deadline).addYears($years).addMonths($months).addDays($days)
            $date   = $date.toString("yyyy-MM-dd")

            sql @"
BEGIN TRANSACTION;

UPDATE expenses
SET deadline = "$date"
where id = $id;

UPDATE expenses 
SET isPaid = 0
WHERE id = $id;

COMMIT;
"@
        }
        else {
            Write-Host "Deadline not updated. Exiting."
            return
        }
    }

    # Display results when done
    view expenses
}