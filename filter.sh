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

function filter_uniq_path() {
    : '
    GIVEN A LIST OF PATHS
    RETURNS THE PATHS THAT ARE NOT CONTAINED IN ANOTHER PATH
    FOR EXAMPLE
    /home/asd/asd
    /home/asd/asd/dd
    WILL RETURN
    /home/asd/asd/dd
    '
    IFS=
    paths=$(cat /dev/stdin)
    echo $paths | while read l
    do
	if [ $(egrep "^$l" <<< $paths | wc -l) -eq 1 ]
	then
	    echo $l
	fi
    done
}

loaded filter
