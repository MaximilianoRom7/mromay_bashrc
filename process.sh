. $home/mromay_bashrc/imports.sh
import logging


function bin_exists() {
    : '
    GIVEN A PROGRAM NAME RETURNS 1 IF IS FOUND IN THE PATH VARIABLE
    '
    if [ $(which "$1" 2> /dev/null) ]
    then
	echo 1
    fi
}

function check_binaries() {
    : '
    CREATES GLOBAL VARIABLES "bin_exists_*" WHERE "*"
    ARE THE NAME OF PROGRAMS
    FOR EXAMPLE "bin_exists_bc" IS 1 IF BC PROGRAM EXISTS
    FOR EXAMPLE "bin_exists_python" IS 1 IF PYTHON EXISTS
    ETC...
    '
    bin_exists_bc=$(bin_exists bc)
    bin_exists_curl=$(bin_exists curl)
    bin_exists_python=$(bin_exists python)
    bin_exists_nslookup=$(bin_exists nslookup)
}

check_binaries

function process_ignore() {
    : '
    CALLS A PROGRAM IN THE BACKGOUND
    '
    nohup "$@" &
}

alias ignore=process_ignore

function process-pid() {
    : '
    AFTER CALLING PS PIPE THIS FUNCTION TO GET THE PID NUMBERS
    LIKE THIS
    ps aux | process-pid
    '
    tr -s ' ' | cut -d ' ' -f 2
}

function process-kill() {
    : '
    AFTER CALLING PS PIPE THIS FUNCTION
    TO KILL ALL THOSE PROCESSES
    LIKE THIS
    ps aux | grep python | process-kill
    THIS WILL KILL ALL THE PYTHON PROCESSES
    '
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

function process_first() {
    : '
    THIS FUNCTION RETURNS THE LIST OF THE FIRST PROCESS
    WITH PID LOWER THAN 1000
    '
    ps -e | while read l
    do
	p=$(cut -d ' ' -f1 <<< $l | egrep -o "[0-9]+" | head -n 1 )
	if [ "$p" ] && [ "$p" -lt 1000 ]
	then
	    s=$(egrep -o "[^ ]+$" <<< $l)
	    if [ $(which $s) ]
	    then
		echo $l
	    fi
	fi
    done | column -t
}


loaded process
