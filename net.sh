. $home/mromay_bashrc/imports.sh
import logging

function net_myip () {
    : '
    TRIES TO GET THE WLAN IP OF
    THIS MACHINE FROM MULTIPLE SOURCES
    '
    p=$(dig +short myip.opendns.com @resolver1.opendns.com | grepip)
    if [ ! $p ]
    then
	p=$(curl ipecho.net/plain | grepip)
    fi
    if [ ! $p ]
    then
	p=$(curl icanhazip.com | grepip)
    fi
    if [ ! $p ]
    then
	p=$(curl ifconfig.me | grepip)
    fi
    echo $p
}


function net_check() {
    : '
    PINGS TO 8.8.8.8 GOOGLE SERVER TO TEST WLAN
    '
    ping 8.8.8.8
}

loaded net
