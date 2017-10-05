. $home/mromay_bashrc/imports.sh
import logging


function split_space_lines() {
    tr -s ' ' $'\n' <<< $@
}

loaded split
