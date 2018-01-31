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

function watch_dir_modify() {
    : '
    Watches all the files in a directory for the events create, delete, modify
    '
    while inotifywait -q -r -e create -e delete -e modify "$1"; do true; done
}

loaded char
