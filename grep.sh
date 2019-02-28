. $home/mromay_bashrc/imports.sh
import logging

function grepc() {
    # the substitution removes the spaces this is an error
    # in order to fix it replace ${@:2} for $2 $3 $4 ...
    # egrep "$1" ${@:2} --color=always | less
    egrep "$1" $2 $3 $4 $5 $6 --color=always | less
}

function greprl() {
    egrep ":.*$1" | less
}

function greprf() {
    egrep ".*$1.*:.*" | less
}

function grep_num() {
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


loaded grep
