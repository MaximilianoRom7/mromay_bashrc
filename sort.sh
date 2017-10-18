. $home/mromay_bashrc/imports.sh
import logging

function bsort() {
    uniq | sort | uniq
}

function sort_count() {
    : '
    SORT AND COUNTS THE FIRST COLUMN IF IT IS A NUMBER
    '
    sort | uniq -c | sort -g -r -t 1 | less
}


loaded sort
