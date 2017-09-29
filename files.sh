. $home/mromay_bashrc/imports.sh
import logging

function tree_sort_time() {
    tree -L 1 -D --timefmt '%H:%M:%S %s' | sort
}

function tree_watch_sort_time() {
    watch -n 2 "tree -L 1 -D --timefmt '%H:%M:%S %s' | sort"
}

loaded files
