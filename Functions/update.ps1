# Routing function
function update ($idString){
    if (-not $idString){Write-Host "`e[31mSPECIFY ID`e[0m"}
    else {
        $parsedID = idParser $idString
        if ($parsedID[0] -eq 0){echo "break!" ; break}
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
    Write-Host (fgo "************************TODO EXPENSES $id*********************")
}