# Routing function
function add ($entity){
    if (-not $entity){Write-Host "`e[31mSPECIFY NAME OF ENTITY (singular form of tablename)`e[0m"}
    else {
        $entity = $entity.ToLower()
            if ($entity -eq 'assignment'){launchAssignmentForm}
        # elseif ($table -eq 'c'){updateCredentials $id}
        # elseif ($table -eq 'e'){updateEvents $id}
        # elseif ($table -eq 't'){updateTasks $id}
        # elseif ($table -eq 'x'){updateExpenses $id}
        else {
            Write-Host "`e[31mNO TABLE ASSOCIATED WITH`e[0m `""$entity"`""
            Write-Host @"
            Try these:`e[92m
            - assignment
            - event
            - task`e[0m
"@
        }
    }
}

function launchAssignmentForm {

    # course

    do {
        [string] $course = Read-Host "Enter Course Code"
        $valid = isValidCourse $course
    } while (-not $valid)

    # description

    $description = Read-Host "Enter description"

    # deadline

    do {
        $deadline = Read-Host "Enter Deadline (Mdd)"
        [int] $month = $deadline / 100
        [int] $day   = $deadline % 100
        $deadline = (date ("2024-" + $month + "-" + $day)).tostring("yyyy-MM-dd")
        $e = 0

        try {date $deadline}
        catch {
            $e = 1
            Write-Host "Invalid date format. Please enter a valid date (Mdd)"
        }
    } while ($e -eq 1)

    # note

    $note = Read-Host "Enter Note"

    # QUERY

    $query  = "INSERT INTO assignments (course,description,deadline,note) "
    $query += "VALUES ($course,`"$description`",`"$deadline`",`"$note`");"
    sql $query
}

# HELPER FUNCTIONS

function isValidCourse ($code){

    $validCourses = @('8288', '8333', '8276', '8277', '8319', '0000')

    if ($validCourses -contains $code) {
        return $true
    }
    else {
        Write-Host "Invalid course. Please enter a valid course number."
        return $false
    }
}