. $home/mromay_bashrc/imports.sh
import logging


function process_ignore() {
    nohup "$@" &
}

alias ignore=process_ignore

loaded process
