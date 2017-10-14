. $home/mromay_bashrc/imports.sh
import logging
import net
import grep
import process

function check-domain() {
    IFS=
    if [ $bin_exists_nslookup ]
    then
	nslookup $1 | grep -i "address: " | grepip
    else
	echo no process nslookup
    fi
}

loaded check
