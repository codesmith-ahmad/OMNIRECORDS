function check {
    param (
        $process
    )

    if ($args.Count -gt 1){Write-Host $red"TOO MANY ARGS"$0d; break}

    if     ($process -match "^*mail*" -or $process -match "\b(tt|timetable)\b"){
        . "C:\OMNIRECORDS\olk.exe.lnk"
    }
    elseif ($process -match "(todo|^*task*)"){
        write-host "${yellow}OPEN ${line}MICROSOFT TO DO$0d`n"
    }
    elseif ($process -match "regex"){
        # template
    }
    else {write-host "`n${red}NO SUCH PROCESS`e[0m`n"}
}