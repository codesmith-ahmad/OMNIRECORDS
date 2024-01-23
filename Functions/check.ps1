function check {
    param (
        $process
    )

    if ($args.Count -gt 1){Write-Host $red"TOO MANY ARGS"$0d; break}

    if     ($process -match "^*mail*" -or $process -match "\b(tt|timetable)\b"){write-host "Email!"}
    elseif ($process -match "(todo|^*task*)"){write-host "${yellow}OPEN ${line}MICROSOFT TO DO$0d`n"}
    else {write-host "`n${red}NO SUCH PROCESS`e[0m`n"}
}