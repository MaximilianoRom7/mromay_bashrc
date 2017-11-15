import logging

function list_manpages() {
    : '
    LIST ALL THE MAN PAGES THAT EXIST IN THE GNU/LINUX SYSTEM
    '
    manpath | tr -s ':' '\n' | while read l
    do
	find -L $l -type f | while read f
	do
	    basename $f | grep -oE "^[^\.]+"
	done
    done
}

loaded list
