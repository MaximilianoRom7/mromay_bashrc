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
    nohup "$@" 2>&1 > /dev/null &
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
    if [ $1 ]; then t=$1; else t=1000; fi
    ps -e | while read l
    do
	p=$(cut -d ' ' -f1 <<< $l | egrep -o "[0-9]+" | head -n 1)
	if [ "$p" ] && [ "$p" -lt $t ]
	then
	    s=$(egrep -o "[^ ]+$" <<< $l)
	    if [ $(which $s) ]
	    then
		echo $l
	    fi
	fi
    done | column -t | less
}

function nopass() {
    : '
    THIS FUNCTION LIST ALL THE PERMISSIONS THAT CAN BE USE WITH SUDO WITHOUT A PASSWORD
    '
    sudo -l | grep -A 1000 NOPASSWD: | sed 's/NOPASSWD:/\n/g' | tr -s ',' $'\n' | tail -n +2
}

function eos_docker_start() {
    docker run --rm --name eosio -d -p 8888:8888 -p 9876:9876 -v /tmp/work:/work -v /tmp/eosio/data:/mnt/dev/data -v /tmp/eosio/config:/mnt/dev/config eosio/eos-dev  /bin/bash -c "nodeos -e -p eosio --plugin eosio::producer_plugin --plugin eosio::history_plugin --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin --plugin eosio::http_plugin -d /mnt/dev/data --config-dir /mnt/dev/config --http-server-address=0.0.0.0:8888 --access-control-allow-origin=* --contracts-console --http-validate-host=false"
}

alias cleos='docker exec -it eosio /opt/eosio/bin/cleos -u http://localhost:8888'


loaded process
