. $home/mromay_bashrc/imports.sh
import logging


function findd() {
    : '
    FIND FOLDERS BY NAME
    $1 IS THE FOLDER NAME
    $2 IS THE PATH
    $3 IS THE DEPTH
    '
    if [[ $1 && $2 && $3 ]]
    then
	find $2 -maxdepth $3 -type d -name \*$1\*
    else
	if [[ $1 && $2 ]]
	then
	    find $2 -type d -name \*$1\*
	else
	    if [[ $1 ]]
	    then
		find . -type d -name \*$1\*
	    else
		find . -type d
	    fi
	fi
    fi
}

loaded find
