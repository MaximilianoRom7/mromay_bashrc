. $home/mromay_bashrc/imports.sh
import logging

function odoo_services_test_load() {
    while $(true)
    do
	curl 0.0.0.0:8050
	curl 0.0.0.0:8060
	curl 0.0.0.0:8070
	curl 0.0.0.0:8080
	curl 0.0.0.0:8090
	sleep 0.1
    done
}

function odoo_services_watch() {
    IFS=
    while $(true)
    do
	st1=$(systemctl status odoo-1)
	st2=$(systemctl status odoo-2)
	st3=$(systemctl status odoo-3)
	st4=$(systemctl status odoo-4)
	st5=$(systemctl status odoo-5)
	status=$(cat <(echo $st1) <(echo $st2) <(echo $st3) <(echo $st4) <(echo $st5))
	clear
	echo $status | egrep -i "^.|odoo-.*|active: "
	sleep 2
    done
}

loaded odoo
