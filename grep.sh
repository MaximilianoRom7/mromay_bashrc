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


loaded grep
