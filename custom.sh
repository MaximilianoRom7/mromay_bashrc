import vars
import char
import path
import logging

function prompt_default() {
    if [ "$color_prompt" = yes ]; then
	echo '${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
	echo '${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
}

function prompt_path_last() {
    : '
    IF THE VARIABLE "prompt_function" IS TRUE
    THIS FUNCTION IS USE TO CHANGE THE SHELL PROMPT VARIABLE
    THE TEXT THAT IS SHOWN AT THE LEFT IN THE SHELL
    THIS FUNCTION CHANGES THE VALUE OF THE PS1 VATIABLE
    '
    if [ $prompt_function ]
    then
	i=4
	l=$(pwd | path_lasts $i)
	c=$(pwd | egrep -o / | wc -l)
	if [ $c -gt $i ]
	then
	    echo ...$l": "
	else
	    echo $l": "
	fi
    else
	prompt_default
    fi
}

function prompt_command() {
    PS1="$(prompt_path_last)"
}

PROMPT_COMMAND=prompt_command

loaded custom
