. $home/mromay_bashrc/imports.sh
import logging

function grepc() {
    egrep "$1" ${@:2} --color=always | less
}

function greprf() {
    egrep ":.*$1" | less
}


loaded grep
