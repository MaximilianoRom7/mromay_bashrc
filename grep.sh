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


loaded grep
