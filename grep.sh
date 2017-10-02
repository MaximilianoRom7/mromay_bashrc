. $home/mromay_bashrc/imports.sh
import logging

function grepc() {
    egrep "$1" ${@:2} --color=always | less
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
