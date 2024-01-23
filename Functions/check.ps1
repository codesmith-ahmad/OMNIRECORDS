function check {
    param (
        $process
    )

    if ($args.Count -gt 1){Write-Host $red"TOO MANY ARGS"$0d; break}

    if     ($process -match "^*mail*" -or $process -match "\b(tt|timetable)\b"){
        . "C:\Program Files\WindowsApps\Microsoft.OutlookForWindows_1.2024.103.100_x64__8wekyb3d8bbwe\olk.exe"
    }
    elseif ($process -match "(todo|^*task*)"){write-host "${yellow}OPEN ${line}MICROSOFT TO DO$0d`n"}
    elseif ($process -match "regex")         {}
    else {write-host "`n${red}NO SUCH PROCESS`e[0m`n"}
}