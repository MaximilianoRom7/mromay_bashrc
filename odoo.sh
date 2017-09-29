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
	status=""
	nl=" \n \n \n "
	status=$status$nl$(systemctl status odoo-1)
	status=$status$nl$(systemctl status odoo-2)
	status=$status$nl$(systemctl status odoo-3)
	status=$status$nl$(systemctl status odoo-4)
	status=$status$nl$(systemctl status odoo-5)
	clear
	echo -e $status | cgrep -i "^.|odoo-.*|active: "
	sleep 2
    done
}

loaded odoo
