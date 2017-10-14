. $home/mromay_bashrc/imports.sh
import logging

function downloads() {
    : '
    LIST ALL THE FILES IN THE DOWNLOADS DIRECTORIES
    OF ALL USERS IF IT HAS PERMISSIONS
    '
    find /root/Downloads -maxdepth 1 2> /dev/null
    find /home/*/Downloads -maxdepth 1 2> /dev/null
}

function tree_sort_time() {
    tree -L 1 -D --timefmt '%H:%M:%S %s' | sort
}

function chunder() {
    : '
    GIVEN A FOLDER CHANGES ALL FILES NAMES WITHIN THAT DIRECTORY
    REPLACING ALL THE SPACES FOR UNDERSCORES
    FOR EXAMPLE IF THE DIRECTORY HAS THE FOLLOWING FILES
    asd asd.txt
    ddd ddd.js
    CALLING "chunder" IN THIS DIRECTORY
    THE FILE NAMES WILL BE CHANGED FOR
    asd_asd.txt
    ddd_ddd.js
    '
    if [ $1 ]
    then
	d=$1
    else
	d=.
    fi
    ls $d/* | while read l
    do
	# if the file contains a space
	if [ $(grep " " <<< "$l") ]
	then
	    # then replace splace for underscore
	    f=$(sed 's/ /_/g' <<< $l)
	    # unless the file alredy exists
	    if [ ! -f $f ]
	    then
		echo $l" >>> "$f
		mv $l $f
	    fi
	fi
    done
}

function tree_watch_sort_time() {
    watch -n 2 "tree -L 1 -D --timefmt '%H:%M:%S %s' | sort"
}

function files_sumsize() {
    : '
    GIVEN A DIRECTORY SUMS UP THE SIZES OF ALL
    THE FILES AND FOLDERS OF THIS DIRECTORY
    '
    du -s $1/* | sum_column $'\t' 1
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
    : '
    CAN GIVE TWO ARGUMENTS
    IF ONE ARGUMENT IS GIVEN IS THE EXTENSION
    IF TWO ARGUMENTS ARE GIVEN THE FIRST ONE IS THE PATH
    TO SEARCH AND THE SECOND ONE IS THE EXTENSION
    FOR EXAMPLE:
    files_with_ext ~ py
    WILL SEARCH IN THE PATH ~ FILES WITH EXTENSION py
    BUT
    files_with_ext py
    THIS WILL SEARCH FILES WITH EXTENSION py
    IN THE CURRENT DIRECTORY
    '
    if [ $2 ]
    then
	find $1 -type f | grep -E "\.$2$"
    else
	find . -type f | grep -E "\.$1$"
    fi
}

alias findext=files_with_ext

loaded files
