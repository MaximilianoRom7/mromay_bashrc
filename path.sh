. $home/mromay_bashrc/imports.sh
import char
import logging

function path_no_ext() {
    grep -oP "^[^\.]+" <<< $1
    
}

function path_last() {
    grep -oP "(?<=/)[^/]+$" <<< $1
}

function path_lasts() {
    read pipe
    r=$(egrep -o "$(char_repeat .[^/]+ $1)$" <<< $pipe)
    if [ $r ]
    then
	echo $r
    else
	echo $pipe
    fi
}

function path_dirname() {
    : '
    Given a number applies N times dirname
    '
    while read l
    do
	start=0
	stop=$1
	while [ $start -lt $stop ]
	do
	    l=$(dirname $l)
	    start=$(( $start + 1 ))
	done
	echo $l
    done
}

loaded path
