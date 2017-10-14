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
