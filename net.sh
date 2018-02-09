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

function net_check_google() {
    : '
    WATCHS FOR EVERY SECOND A CURL TO GOOGLE.COM.AR
    '
    watch -n 1 'curl "https://www.google.com.ar/" 2> /dev/null | egrep -o ".{1,150}"'
}

function net_connect() {
    # check if it is alredy connected
    # if not then connect to a wifi
    timeout 0.2 ping -c 1 8.8.8.8 > /dev/null
    if [ ! $? -eq 0 ]
    then
	IFS=
	home=wlp9s0-Speedy-675258
	if [ $(netctl list | grep $home) ]
	then
	    net=$home
	else
	    echo "Choose a Wifi Network:"
	    nets=$(cat -n <(netctl list))
	    echo $nets
	    echo -n "Option: "
	    read line </dev/stdin
	    net=$(echo $nets | sed $line'q;d' | tr -s ' ' | cut -d ' ' -f 3)
	    # echo "line: " $line
	    # echo "nets: " $nets
	    # echo "net: " $net
	fi
	sudo /usr/lib/netctl/network stop $net
	sudo /usr/lib/netctl/network start $net
    fi
}

loaded net
