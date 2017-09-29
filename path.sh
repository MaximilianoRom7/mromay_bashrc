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

loaded path
