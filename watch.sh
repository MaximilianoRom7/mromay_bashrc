import logging
import process

function watch_process_file() {
    IFS=
    while true
    do
	out=$(ps aux | grep "$@" | grep -v grep | process-pid | xargs -L 1 lsof -n -p | cut -c 63- | bsort)
	clear
	echo $out
	sleep 0.2
    done
}

loaded char
