. $home/mromay_bashrc/imports.sh
import logging


function process_ignore() {
    nohup "$@" &
}

function process-pid() {
    tr -s ' ' | cut -d ' ' -f 2
}

function process-kill() {
    IFS=
    while read l
    do
	if [[ "$l" =~ "^[0-9]+$" ]]
	then
	    pid=$l
	else
	    pid=$(echo $l | process-pid)
	fi
	kill -9 $pid
    done
}

alias ignore=process_ignore

loaded process
