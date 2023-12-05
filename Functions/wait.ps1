function wait ($sleeptime){
    if (-not $sleeptime){$sleeptime = 50} # Default sleeptime is 50 milliseconds
    start-sleep -Milliseconds $sleeptime
}