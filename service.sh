import logging
import files

function services() {
    systemctl list-unit-files | egrep -o "^[^ ]+\.service"
}

function service_files() {
    services | while read l
    do
	systemctl status $l 2> /dev/null
    done | egrep -o "/[^ ]+\.service" | filter_files
}

loaded service
