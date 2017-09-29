. $home/mromay_bashrc/imports.sh
import char
import path
import logging

function prompt_path_last() {
    i=4
    l=$(pwd | path_lasts $i)
    c=$(pwd | egrep -o / | wc -l)
    if [ $c -gt $i ]
    then
	echo ...$l": "
    else
	echo $l": "
    fi
}

function prompt_command() {
    PS1="$(prompt_path_last)"
}

PROMPT_COMMAND=prompt_command

loaded custom
