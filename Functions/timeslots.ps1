function create-timeslots {
    $c = 1
    $w = 0
    $h = 0
    $m = 0

    while ($w -lt 7){

        $timeslotId = $w*1000 + $h*10 + $m*5
        $startTime = date ("$h" + ":" + $m * 30)
        $endTime   = $startTime.AddMinutes(30)
        $startString = $startTime.ToString("HH:mm")
        $endString   = $endTime.ToString("HH:mm")

        write-host "($timeslotId, $w, `"$startString`", `"$endString`"),"

        $m++
        if ($m -eq 2){
            $h++
            $m = 0
            if ($h -eq 24){
                $w++
                $h = 0
            }
        }

    }

}

# Testing purposes only
# create-timeslots