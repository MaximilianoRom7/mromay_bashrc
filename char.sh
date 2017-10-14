. $home/mromay_bashrc/imports.sh
import logging

function char_count() {
    : '
    GIVEN TEXT COUNTS HOW MANY CHARACTERS THE LINES HAVE
    FOR EXAMPLE
    echo asdasdasd | char_count
    RETURNS 9
    '
    echo $@ | grep -o '.' | wc -l
}

function char_line_width() {
    : '
    GIVEN LINES THIS FUNCTION CUTS THE LINES AT THE WIDTH
    SPECIFIED FOR THE ARGUMENT
    echo 1234567890 | char_line_width 3
    RETURNS 123
    '
    egrep -o "^.{1,"$1"}"
}

function char_line_width_split() {
    : '
    GIVEN LINES THIS FUNCTION SPLITS THE LINES AT THE WIDTH
    SPECIFIED FOR THE ARGUMENT
    echo 1234567890 | char_line_width 3
    RETURNS 123
    456
    789
    0
    '
    egrep -o ".{1,"$1"}"
}

function char_repeat() {
    : '
    GIVEN TWO ARGUMENTS A CHARACTER AND A NUMBER
    REPEATS THE CHARACTER AS MANY TIMES AS THE NUMBER
    FOR EXAMPLE
    char_repeat x 5
    RETURNS xxxxx
    '
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
