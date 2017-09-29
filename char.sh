. $home/mromay_bashrc/imports.sh
import logging

function char_count() {
    echo $@ | grep -o '.' | wc -l
}

function char_line_width() {
    egrep -o "^.{1,"$1"}"
}

alias less="less -RS"


loaded char
