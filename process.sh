. $home/mromay_bashrc/imports.sh
import logging


function bin_exists() {
    if [ $(which "$1" 2> /dev/null) ]
    then
	echo 1
    fi
}

function check_binaries() {
    bin_exists_bc=$(bin_exists bc)
    bin_exists_python=$(bin_exists python)
}

check_binaries

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
