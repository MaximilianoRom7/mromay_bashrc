import logging


function split_space_lines() {
    tr -s ' ' $'\n' <<< $@
}

loaded split
