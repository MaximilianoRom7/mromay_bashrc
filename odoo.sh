. $home/mromay_bashrc/imports.sh
import sort
import grep
import path
import logging
import process
import split

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
	echo -e $status | grepc -i "^.|odoo-.*|active: "
	sleep 2
    done
}

function odoo_addons_change_version() {
    IFS=
    split_space_lines $@ | while read l
    do
	if [ -d "$l" ]
	then
	    echo "Updating ./"$(ls -d $l/)" ..."
	    odoo_addons_versions $l
	fi
    done
}

function odoo_addons_versions() {
    if [ $1 ]
    then
	p=$(pwd)
	split_space_lines $@ | while read t
	do
	    if [ $t ] && [ -d $t ]
	    then
		cd $t
		egrep -rn ".version.:" --include __openerp__.py --include __manifest__.py | while read l
		do
		    echo $1/$l
		done
		cd $p
	    fi
	done | column -t
	cd $p
    else
	egrep -rn ".version.:" --include __openerp__.py --include __manifest__.py | column -t
    fi
}

function odoo_view_search() {
    grepc "$1" $2 $3 $4 $5 $6 -ri --include \*.xml
}

function odoo_view_models() {
    odoo_view_search ">[^<]+<" | egrep "<field name=\"model\"" | tr -s ' ' | less
}

function odoo_find_addons_folders() {
    find ~ -type d | egrep -o ".*(/odoo[^/]*/|/openerp/)addons/" | bsort
}

function odoo_find_odoos() {
    IFS=
    odoo_find_addons_folders | egrep -v /repos/ | path_dirname 2
}

function odoo_kill() {
    ps aux | grep python | grep odoo | grep -v "grep " | process-kill
}

function odoo_choose_addons_folder() {
    IFS=
    addons_folders=$(odoo_find_addons_folders | egrep -v /repos/)
    lines=$(wc -l <<< $addons_folders)
    echo $addons_folders | cat -n
    option=-1
    while [ $option -gt $lines ] || [ $option -lt 0 ]
    do
	echo -n "Choose an option: "
	read option
	if [ ! $(grep_num $option) ]
	then
	    option=-1
	fi
    done
    folder=$(echo $addons_folders | sed $option'q;d')
    cd $folder
}

loaded odoo
