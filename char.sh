. $home/mromay_bashrc/imports.sh
import logging

function char_count() {
    echo $@ | grep -o '.' | wc -l
}

function char_line_width() {
    egrep -o "^.{1,"$1"}"
}

function char_repeat() {
    if [ ! $2 ]
    then
	return 1
    fi
    repeat=""
    t=$2
    c=$1
    while [ $t -gt 0 ]
    do
	t=$(( $t - 1 ))
	repeat=$repeat$c
    done
    echo $repeat
}

alias less="less -RS"


loaded char
