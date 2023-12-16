function update ($id){
    if (-not $id){Write-Host "SPECIFY ID"}
    $id = $id.ToLower()
    if ($id[0] -eq 'x'){echo "ITS X"}
    else {
        Write-Host "NO TABLE ASSOCIATED WITH" $id[0]
        Write-Host @"
        A: Assignments
        C: Credentials
        D: Documents
        E: Events
        L: Loans
        T: Tasks
        X: Expenses
"@
    }
}