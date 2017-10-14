. $home/mromay_bashrc/imports.sh
import logging

function msg_pts() {
    : '
    GIVEN TWO ARGUMENTS THE PST FILE NUMBER AND A MESSAGE
    WRITES THAT MESSAGE INTO THE /DEV/PST/<NUMBER> FILE
    '
    if [ $(egrep "tty." <<< $1) ]
    then
	echo "${@:2}\n" >> /dev/$1
    else
	echo "${@:2}\n" >> /dev/pts/$1
    fi
}

loaded message
