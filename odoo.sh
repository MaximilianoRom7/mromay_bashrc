. $home/mromay_bashrc/imports.sh
import sort
import grep
import path
import logging
import process
import split
import filter

function odoo_services_test_load() {
    : '
    IN THE DEVELOPMENT TESTING SERVER THERE ARE 5 ODOOS RUNNING
    THIS FUNCTION MAKES AN HTTP CALL TO EVERY ONE OF THESE ODOOS
    EVERY 0.1 SECONDS
    THIS IS A LOADING TEST
    '
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
    : '
    ATTENTION: THIS FUNCTION EXIST WITH AND WITHOUT S AT THE END
    THAT MEANS THAT BOTH FUNCTION EXISTS
    odoo_addons_change_version
    odoo_addons_change_versions
    THEY ARE DIFFERENT

    GIVEN A VERSION NUMBER AND A ADDON NAME, REPLACES THIS VERSION
    IN THE MANIFEST OF THIS ADDON

    THIS FUNCTION IS DIFFERENT FROM THE odoo_addons_change_versions
    BECOUSE THIS ONE IS APPLY FOR EVERY ADDON ONE AT THE TIME

    odoo_addons_change_versions <NEW VERSION> <ADDON FOLDER NAME>

    FOR EXAMPLE:
    odoo_addons_change_versions 10.0.0.12 l10n_ar_afipws
    REPLACES THE VERSION 10.0.0.12 IN THE l10n_ar_afipws ADDON
    '
    c1=$(cut -d ':' -f1 <<< $1)
    if [ -f $c1 ]
    then
	c2=$(egrep -io ".version.:.+$" <<< $2)
	c3=$(sed "s/.version.:.*/'version': '"$odoo_addons_version"',/g" <<< $c2)
	sed -i.bk "s/.version.:.*/'version': '"$odoo_addons_version"',/g" $c1
	echo $c1 $c2" >>> "$c3
    fi
}

function odoo_addons_change_versions() {
    : '
    ATTENTION: THIS FUNCTION EXIST WITH AND WITHOUT S AT THE END
    THAT MEANS THAT BOTH FUNCTION EXISTS
    odoo_addons_change_version
    odoo_addons_change_versions
    THEY ARE DIFFERENT

    GIVEN A VERSION NUMBER AND A FOLDER, SEARCHS WITHIN THIS FOLDER
    ALL THE ADDONS IT CAN FOUND AND REPLACES THE VERSION NUMBER
    IN ALL OF THEM
    THIS FUNCTION USES "odoo_addons_change_version"

    odoo_addons_change_versions <NEW VERSION> <ADDON GROUP FOLDER NAME>

    FOR EXAMPLE:
    odoo_addons_change_versions 10.0.0.12 locale_ar
    REPLACES THE VERSION 10.0.0.12 IN ALL THE ADDONS WITHIN locale_ar
    '
    IFS=
    odoo_addons_version=$1
    split_space_lines $2 $3 $4 $5 $6 | while read l
    do
	if [ -d "$l" ]
	then
	    # echo "Updating_/"$(ls -d $l/)"_..."
	    odoo_addons_versions $l
	fi
    done | grepr_file_content odoo_addons_change_version | column -t
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
		egrep -Rn ".version.:" --include __openerp__.py --include __manifest__.py 2> /dev/null | while read l
		do
		    echo $1/$l
		done
		cd $p
	    fi
	done | column -t
	cd $p
    else
	egrep -Rn ".version.:" --include __openerp__.py --include __manifest__.py 2> /dev/null | column -t
    fi
}
    
function odoo_fields_find() {
    : '
    GIVEN A FIELD NAME THIS FUNCTION RETURNS ALL THE PYTHON
    FILES THAT CONTAINS THE FIELD
    YOU HAVE TO BE IN A ODOO FOLDER
    '
    egrep -R "^[^#]+$1 = field[^(]+\(" . --include \*.py 2> /dev/null | egrep -v /locale_ar
}

function odoo_models() {
    egrep -R "(_name = ['\"]|_inherit = ['\"])" . --include \*.py 2> /dev/null
}

function odoo_view_search() {
    grepc "$1" $2 $3 $4 $5 $6 -Ri --include \*.xml 2> /dev/null
}

function odoo_view_models() {
    odoo_view_search ">[^<]+<" | egrep "<field name=\"model\"" | tr -s ' ' | less
}

function odoo_find_addons() {
    : '
    FIND ALL THE ADDONS IN THE CURRENT DIRECTORY
    '
    find -L . -type f -name \*.py | egrep "/__openerp__\.py$|/__manifest__\.py$" | while read l
    do
	dirname $l
    done | bsort
}

function odoo_find_addons_folders() {
    find -L ~ -type d | egrep -o ".*(/odoo[^/]*/|/openerp/)addons/" | bsort
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

function odoo_addons_autoinstalled() {
    : '
    LIST ALL THE ADDONS THAT ARE AUTOINSTALLED
    WHEN CREATING A NEW ODOO DATABASE
    '
    egrep -R "['\"]auto_install['\"]: True" --include __\*__.py | while read l
    do
	basename $(egrep -o "^.+/" <<< $l)
    done | bsort
}

function odoo_find_within_addons() {
    : '
    FIND TEXT WITHIN THE *.PY FILES IN THE ADDONS
    '
    IFS=
    search=$(egrep -R "$@" . --include \*.py 2> /dev/null)
    search2=$(egrep "/addons/" <<< $search)
    if [ "$search2" ]
    then
	search=$search2
    fi
    egrep -v "l10n_" <<< $search | grepr_folders | filter_uniq_path
}

function odoo_addon_fields() {
    : '
    LIST ALL THE FIELDS FROM THE ADDON
    '
    files_with_ext py | egrep -v "__" | while read l
    do
	egrep -o "$1[^ ]* = fields\..{1,100}" $l | egrep ".* =" | while read f
	do
	    echo "$l: $f"
	done
    done
}

loaded odoo
