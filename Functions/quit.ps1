function quit {
    $timestamp = (get-date).tostring("yyy-MMM-dd Thhmm")
    sync $timestamp

    exit
}