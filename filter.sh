. $home/mromay_bashrc/imports.sh
import logging

function filter_lines_width() {
    while read l
    do
	w=$(wc -c <<< $l)
	if [ $w -lt $1 ]
	then
	    echo $l
	fi
    done
}

loaded filter
