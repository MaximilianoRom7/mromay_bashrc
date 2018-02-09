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

function service_props_count() {
    service_files | while read l; do echo $(cat $l | grep -oP "^[^=]+(?==)" | wc -l) $l; done | sort -g -r -k 1 | less
}

loaded service
