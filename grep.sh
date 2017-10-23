. $home/mromay_bashrc/imports.sh
import logging

function grepc() {
    : '
    the substitution removes the spaces this is an error
    in order to fix it replace ${@:2} for $2 $3 $4 ...
    egrep "$1" ${@:2} --color=always | less
    '
    egrep "$1" $2 $3 $4 $5 $6 --color=always | less
}

function grepext() {
    : '
    GIVEN AND EXTENSION AND A LIST OF FILES RETURNS
    THE LIST OF FILES THAT MATCHES THE EXTENSION AT THE END

    FOR EXAMPLE:
    echo __init__.py | grepext txt
    RETURNS NOTHING, BUT

    echo __init__.py | grepext py
    RETURNS __init__.py
    '
    egrep $1"$"
}

function greprr() {
    : '
    AFTER A RECURSIVE GREP LIKE THIS "grep -R $1"
    AND AN ARGUMENT TO MATCH FOR
    THIS FUNCTION RETURNS THE LINES THAT MATCH THAT ARGUMENT
    AT THE RIGHT OF THE COLON ":"
    FOR EXAMPLE
    echo "__init__.py: def func():" | greprr asd
    RETURNS NOTHING BECOUSE AT THE RIGHT OF THE COLON "asd" DIDNT MATCH, BUT

    echo "__init__.py: def func():" | greprr func
    RETURNS __init__.py: def func():
    BECOUSE AT THE RIGTH OF THE COLON THERE IS " def func():" AND "func" WAS FOUND
    '
    egrep ":.*$1" | less
}

function greprl() {
    : '
    AFTER A RECURSIVE GREP LIKE THIS "grep -R $1"
    AND AN ARGUMENT TO MATCH FOR
    THIS FUNCTION RETURNS THE LINES THAT MATCH THAT ARGUMENT
    AT THE LEFT OF THE COLON ":"
    FOR EXAMPLE
    echo "__init__.py: def func():" | greprl asd
    RETURNS NOTHING BECOUSE AT THE LEFT OF THE COLON "asd" DIDNT MATCH, BUT

    echo "__init__.py: def func():" | greprl init
    RETURNS __init__.py: def func():
    BECOUSE AT THE LEFT OF THE COLON THERE IS "__init__.py" AND "init" WAS FOUND
    '
    egrep ".*$1.*:.*" | less
}

function grep_num() {
    : '
    GIVEN TEXT MATCHES A EXACT NUMBER FROM THE BEGINNING TO THE END
    IN CASE IS NOT A NUMBER RETURNS NOTHING
    THAN MEANDS THAT FOR EXAMPLE:

    echo a11112 | grep_num
    RETURNS NOTHING, BUT

    echo 11112 | grep_num
    RETURNS 11112
    '
    egrep "^[0-9]+$" <<< $1
}

function grepr_file_content() {
    # $1 is a function to call
    # that consumes the variables c1 and c2
    if [ $1 ]
    then
       while read l
       do
	   c1=$(egrep -o "^[^:]+:" <<< $l)
	   c2=$(egrep -o ':.+$' <<< $l)
	   $1 $c1 $c2
       done
    fi
}

function grepip () {
    : '
    GIVEN TEXT CHECKS IF IT IS A VALID IP ADDRESS
    FOR EXAMPLE
    echo 192.168.1.1 | grepip
    RETURNS
    192.168.1.1
    BUT
    echo a.168.1.1 | grepip
    RETURNS NOTHING
    '
    grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
}

function grep_uncomment () {
    : '
    GIVEN TEXT RETURNS THE LINE THAT ARE NOT COMMENTED
    FOR EXAMPLE
    """
    # a
    b
    c
    #d
    e
    """ | grep_uncomment
    RETURNS
    b
    c
    e
    '
    grep -oP "^[^#]+(?<=\w|\}|\{).*"
}

function grep_multitail() {
    : '
    GIVEN A PATH APPLIES TAIL TO ALL THE *.LOG FILES
    IN THAT DIRECTORY
    FOR EXAMPLE
    grep_multitail /var/log
    WILL MAKE TAIL IN AL THE LOG FILES IN /VAR/LOG
    LIKE
    tail /var/log/Xorg.0.log
    tail /var/log/Xorg.1.log
    AT THE SAME TIME
    '
    if [[ $3 ]]
    then
	ls $1/*.log | while read l; do echo " -f $l"; done | sort | \
	    awk "((NR + $3) % $2) == 0" | xargs tail
    else
	ls $1/*.log | while read l; do echo -en " -f $l"; done | xargs tail
    fi
}

function grepr_files() {
    : '
    GET THE FILES FROM THE RECURSIVE GREP
    '
    egrep -o "^[^:]+" 2> /dev/null | bsort
}

function grepr_folders() {
    : '
    GET THE FOLDERS FROM THE RECURSIVE GREP
    '
    grepr_files | xargs -L 1 dirname | bsort
}


loaded grep
