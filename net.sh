. $home/mromay_bashrc/imports.sh
import logging

function myip () {
    dig +short myip.opendns.com @resolver1.opendns.com
    # curl ipecho.net/plain
    # curl icanhazip.com
    # curl ifconfig.me
}

loaded net
