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
	    if [ $l = "/" ]
	    then
		start=$stop
	    else
		start=$(( $start + 1 ))
	    fi
	done
	echo $l
    done
}

function path_uniq() {
    : '
    GIVEN A LIST OF PATHS IF ANY
    PATH IS PARENT OF THE OTHERS THEN THIS PATH IS OMMITED
    FOR EXAMPLE
    /root/asd
    /root/asd/asd
    /root/media
    /root/media/asd
    IF YOU APPLY THIS FUNCTION TO THESE PATHS
    THE RESULT WILL BE
    /root/asd/asd
    /root/media/asd
    '
    IFS=
    std=$(cat /dev/stdin)
    echo $std | while read l
    do
	if [ $(egrep "^$l" <<< "$std" | wc -l) -eq 1 ]
	then
	    echo $l
	fi
    done | bsort
}

loaded path
