. ~/mromay_bashrc/imports.sh
import char
import logging

function restart_docker_odoo() {
	sudo systemctl reload odoo-1
	sudo systemctl reload odoo-2
	sudo systemctl reload odoo-3
	sudo systemctl reload odoo-4
	sudo systemctl reload odoo-5
}

function test_odoo() {
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

function watch_odoos() {
	while $(true)
	do
		clear
		cat <(systemctl status odoo-1) <(systemctl status odoo-2) <(systemctl status odoo-3) <(systemctl status odoo-4) <(systemctl status odoo-5) | egrep -i "^.|odoo-.*|active: "
		sleep 2
	done
}

function post_json() {
	json=$(to_json "${@:2}")
	if [ $(char_count $json) -gt 4 ]
	then
		curl -H "Content-Type: application/json" -X POST -d "$json" $1
	else
		echo NOT ENOUGH DATA
	fi
}

function to_json() {
	IFS=
	lines=$(echo $@ | egrep -o "[^ ]+ [^ ]+")
	lines=$(echo $lines | sed 's/ /": "/g')
	lines=$(echo $lines | tr -s '\n' '/' | sed 's/.$//g')
	lines=$(echo $lines | sed 's/\//", "/g')
	echo '{"'$lines'"}'
}

loaded base
