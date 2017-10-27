. $home/mromay_bashrc/imports.sh
import logging


function findd() {
    : '
    FIND FOLDERS BY NAME
    $1 IS THE FOLDER NAME
    $2 IS THE PATH
    $3 IS THE DEPTH
    '
    if [ "$3" ]
    then
	find -L "$2" -maxdepth "$3" -type d -name \*"$1"\* 2> /dev/null
    else
	if [ "$2" ]
	then
	    find -L "$2" -type d -name \*"$1"\* 2> /dev/null
	else
	    if [ "$1" ]
	    then
		find -L . -type d -name \*"$1"\* 2> /dev/null
	    else
		find -L . -type d 2> /dev/null
	    fi
	fi
    fi
}

loaded find
