. ~/mromay_bashrc/imports.sh
import logging

function json_post() {
	json=$(to_json "${@:2}")
	if [ $(char_count $json) -gt 4 ]
	then
		curl -H "Content-Type: application/json" -X POST -d "$json" $1
	else
		echo NOT ENOUGH DATA
	fi
}

function json() {
	IFS=
	lines=$(echo $@ | egrep -o "[^ ]+ [^ ]+")
	lines=$(echo $lines | sed 's/ /": "/g')
	lines=$(echo $lines | tr -s '\n' '/' | sed 's/.$//g')
	lines=$(echo $lines | sed 's/\//", "/g')
	echo '{"'$lines'"}'
}

loaded json