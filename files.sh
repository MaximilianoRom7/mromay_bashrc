. $home/mromay_bashrc/imports.sh
import logging

function tree_sort_time() {
    tree -L 1 -D --timefmt '%H:%M:%S %s' | sort
}

function tree_watch_sort_time() {
    watch -n 2 "tree -L 1 -D --timefmt '%H:%M:%S %s' | sort"
}

function files_count_lines() {
    read -t 0.2 files
    IFS=
    if [ $files ]
    then
	xargs -L 1 cat | egrep "^." | wc -l
    else
	if [ $1 ]
	then
	    files_with_ext $1 | xargs -L 1 cat | egrep "^." | wc -l
	else
	    echo "ERROR !"
	fi
    fi
}

function files_with_ext() {
    find . -type f -name \*.$1
}

loaded files
