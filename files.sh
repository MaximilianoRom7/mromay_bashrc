import logging
import char

function downloads() {
    : '
    LIST ALL THE FILES IN THE DOWNLOADS DIRECTORIES
    OF ALL USERS IF IT HAS PERMISSIONS
    '
    find -L /root/Downloads -maxdepth 1 2> /dev/null
    find -L /home/*/Downloads -maxdepth 1 2> /dev/null
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
    command ls -d $d/* | while read l
    do
	# if the file contains a space
	if [ $(grep " " <<< "$l") ]
	then
	    # then replace splace for underscore
	    f=$(sed 's/ /_/g' <<< $l)
	    # f=$(echo $f | char_scape_parent)
	    # f=$(echo $f | char_scape_brack)
	    # unless the file alredy exists
	    if [ ! -f $f ]
	    then
		echo $l" >>> "$f
		mv "$l" "$f"
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
	find -L $1 -type f | grep -E "\.$2$"
    else
	find -L . -type f| grep -E "\.$1$"
    fi
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

alias findext=files_with_ext

function dirdepth() {
    : '
    CUTS THE PATH TO THE $2 LENGTH
    FOR EXAMPLE
    echo /a/a/a/a | dirdepth 2
    RETURNS
    /a/a
    '
    if [ ! $2 ]
    then
	a=1
	b=$1
    else
	a=$1
	b=$2
    fi
    grep -oE "^(/\w+){$a,$b}"
}

function files_binaries() {
    : '
    THIS FUNCTION GETS ALL THE BINARY FILES
    FROM THE DIRECTORIES IN THE $PATH SYSTEM VARIABLE
    ~/.bins is a cached file of this function
    '
    if [ ! -f ~/.bins ]
    then
	echo echo $PATH | tr -s ":" "\n" | while read l
	do
	    find -L $l -type f -executable 2> /dev/null
	done | tee ~/.bins
    else
	cat ~/.bins
    fi
}

function files_noext() {
    : '
    FIND FILES WITHOUT EXTENSION
    '
    if [ ! $1 ]
    then
	p=.
    else
	p=$1
    fi
    find -L $p -type f | egrep -v "/\.git/" | egrep "/[^\.]+$"
}

function files_type_text() {
    : '
    RETURNS THE FILES THAT ARE TEXT LIKE ASCII OR UTF-8
    '
    while read l
    do
	file "$l"
    done | egrep -i ":.* text" | egrep -o "^[^:]+"
}

function files_contains() {
    : '
    LISTS THE FILES THAT CONTAINS THE STRING
    '
    p=$(sed 's/\./\\./g' <<< "$1")
    if [ "$2" ]
    then
	find -L -type f -name "$2" | while read l; do if [[ $(egrep "$p" "$l") ]]; then echo $l; fi; done
    else
	find -L -type f | while read l; do if [[ $(egrep "$p" "$l") ]]; then echo $l; fi; done
    fi
}

function files_perms() {
    : '
    LIST THE FILES AND THEIR PERMISSIONS
    THE DIFFERENCE FROM ls -lR IS THAT THIS COMMAND SHOWS THE FULL PATH
    '
    if [ -d "$1" ]
    then
	d="$1"
    else
	d="."
    fi
    find "$d" -type f | xargs -L 1 ls -l | column -t | less
}

function links_from_folder() {
    : '
    MAKE LINKS FROM EVERY FILE AND FOLDER WITHIN $1
    IN THE CURRENT DIRECTORY
    '
    if [ -d "$1" ]
    then
        d="$1"
        ls -d "$d"/*/ | while read l
        do
            b=$(basename "$l")
            # IF SYMBOLIC LINK DOES NOT EXIST THEN MAKE LINK
            if [ ! -L $b ]
            then
                ln -s "$l" "$b"
            fi
        done
    fi
}


loaded files
