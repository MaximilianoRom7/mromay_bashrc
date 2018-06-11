import sort
import grep
import path
import logging
import process
import split
import filter
import git
import files

function odoo_services_test_load() {
    : '
    IN THE DEVELOPMENT TESTING SERVER THERE ARE 5 ODOOS RUNNING
    THIS FUNCTION MAKES AN HTTP CALL TO EVERY ONE OF THESE ODOOS
    EVERY 0.1 SECONDS
    THIS IS A LOADING TEST
    '
    if [ "$1" ]
    then
	while $(true)
	do
	    echo "50 60 70 80 90" | tr -s ' ' $'\n' | while read l
	    do
		curl 0.0.0.0:80$l
	    done
	    sleep "$1"
	done
    else
	while $(true)
	do
	    echo "50 60 70 80 90" | tr -s ' ' $'\n' | while read l
	    do
		curl 0.0.0.0:80$l
	    done
	done
    fi
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
    egrep -nR "^[^#]+$1 = field[^(]+\(" . --include \*.py 2> /dev/null | egrep -v /locale_ar
}

function odoo_grep_singleton() {
    egrep "^.|\[\[.+\]\]|[ ]*[^ ]+\([0-9]+(, [0-9]+)+\)" --color=always
}

function odoo_fields_selection() {
    grep -nRA 8 "fields\.Selection(" --include \*.py | egrep -i "$@"
}

function odoo_models() {
    search="(^[ \t]*_name = ['\"]|^[ \t]*_inherit = ['\"])"
    egrep -R "$search" . --include \*.py 2> /dev/null
}

function odoo_models_names() {
    odoo_models | while read l
    do
        grep -oP "(?<=['\"]).*(?=['\"])" <<< "$l"
    done | bsort
}

function odoo_view_search() {
    grepc "$1" $2 $3 $4 $5 $6 -Ri --include \*.xml 2> /dev/null
}

function odoo_view_models() {
    odoo_view_search "model=['\"][^'\"]+['\"]" -o | cut -d ':' -f2 | sort_count
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

function odoo_tag_last() {
    git tag | egrep "10\." | sort | tail -1
}

function odoo_repos_updated() {
    : '
    THIS FUNCTION HAS TO BE CALLED WHERE A FILE CALLED "repos" EXISTS
    THIS FUNCTION USES THIS FILE AND COMPARES THE REPOSITORIES
    LAST GIT TAG AGAINS THE TAG IN THE FILE "repos" TO SEE IF THERE
    IS A DIFFERENCE

    EXAMPLE:

    ADDONS                     LAST_TAG         REPOS_TAG
    =========================  ===============  ===============
    account_payment_fix        -10.0.0.0.5-     -10.0.0.0.4-
    locale_ar                  -10.0.0.0.8-     -10.0.0.0.5-
    aeroo_reports              -10.0.0.0.4-     -10.0.0.0.3-
    l10n_ar_aeroo              -10.0.0.14-      -10.0.0.10-
    pyafipws                   -10.0.0.0.3-     -10.0.0.0.2-
    sales_picking_rel          -10.0.0.1-       -10.0.0.0.2-
    sale_stock                 -10.0.0.0.2-     -10.0.0.0.1-
    '
    f="repos"
    if [ ! -f "$f" ]
    then
	echo "$f file does not exist"
	return
    fi
    IFS=
    c=$(cat "$f")
    k=$(pwd)
    git_login_longer
    cat <(echo "ADDONS                     LAST_TAG        REPOS_TAG") \
        <(echo "=========================  =============== ===============") \
        <(echo $c | while read l
	  do
	      r=$(grep -oP "[^ /]+ [^ ]+$" <<< $l | sed 's/\.git//g')
	      r1=$(cut -d ' ' -f1 <<< $r)
	      r2=$(cut -d ' ' -f2 <<< $r)
	      p=$(find .. -type d -name "$r1" 2> /dev/null | head -n 1)
	      if [ "$p" ]
	      then
		  cd $p
		  git fetch 2>&1 > /dev/null
		  v=$(odoo_tag_last)
		  if [ ! "$v" == "$r2" ]
		  then
		      echo "$r1 -$v- -$r2-"
		  fi
		  cd $k
	      fi
	  done) | column -t
}

function odoo_services_restart() {
    : '
    RESTARTS THE ODOO SERVICES RUNNING IN DOCKER
    ODOO-1 ODOO-2 ODOO-3 ODOO-4 ODOO-5
    '
    seq 5 | while read l
    do
	sudo systemctl restart odoo-$l
    done
}

function odoo_data() {
    ps aux | grep odoo | grep python | tr -s ' ' | cut -d ' ' -f 12,13,14,15,16 | grep "\-\-config" | bsort
}

function odoo_confs() {
    if [ $1 ]; then data=$@; else data=$(odoo_data); fi
    cat <(echo $data | egrep -o "\-\-config.*" | grep -oP "/.*|(?<= ).*") \
	<(ls /etc/odoo*.conf 2> /dev/null) | bsort
}

function odoo_conf_value() {
    IFS=
    echo
    data=$(odoo_data)
    echo $data | while read l
    do
	conf=$(odoo_confs $l)
	g=$(egrep "$@" $conf)
	if [ "$g" ]; then echo -e "$l"; echo -e "$g\n"; fi
    done
}

function odoo_conf_basic() {
    odoo_conf_value "^addon|^long|^xmlrpc_port"
}

function odoo_addons_mod() {
    : '
    LIST THE ADDONS THAT ARE MODIFIED IN THIS REPOSITORY
    '
    mod=$(git status | egrep "modified:" | grep -oP "(?<=:).*" | sed 's/ //g' | path_to_abs | files_type_text)
    a=$(echo "$mod" | grep "/addons/")
    if [ "$a" ]
    then
	mod="$a"
    fi
    echo "$mod"
}

function odoo_addons_diff() {
    : '
    LIST ALL THE MODIFICATIONS OF THE ADDONS
    '
    odoo_addons_mod | git_diff
}

function odoo_view_fields_props() {
    : '
    THIS FUNCTION RETURNS THE LIST OF FIELD PROPS USED IN ODOO LIKE THIS:

    attrs
    avg
    class
    clickable
    colspan
    context
    default_focus
    digits
    domain
    editable
    ...
    '
    egrep -R "<field " --include \*.xml | grep -oP "(?<= )[a-zA-Z\-_]+(?==['\"])" | bsort
}

function odoo_backup_unzip() {
    : '
    UNZIP A ZIP FILE INTO A FOLDER WITH THE SAME NAME BUT WITHOUT THE EXTENSION
    TAKES ONE ARGUMENT THE ZIP FILE
    EXAMPLE:
    odoo_backup_unzip minetech.zip
    DECOMPRESS INTO THE FOLDER "minetech"
    IF NOT FILE IS GIVEN DECOMPRESS ALL THE FILES IN THE DIRECTORY
    '
    if [ -f "$1" ]
    then
	d=$(sed 's/\.zip$//'<<< $1)
	mkdir $d
	yes | unzip "$l" -d "$d"
    else
	ls *.zip | while read l
	do
	    d=$(sed 's/\.zip$//'<<< $l)
	    mkdir $d
	    yes | unzip "$l" -d "$d"
	done
    fi
}

function odoo_create_basic() {
    : '
    CREATE AN SQUELETON, EMPTY ADDON
    '
    echo -n "Name of the addon ?: "
    read addon_name </dev/stdin
    addon_name=$(echo $addon_name | tr -s ' ' | sed 's/ /_/g')
    mkdir $addon_name
    touch $addon_name/__init__.py
    mkdir $addon_name/models
    mkdir $addon_name/views
    cp $bpath/addon_squeleton/__openerp__.py $addon_name/__openerp__.py
    cp $bpath/addon_squeleton/view.xml $addon_name/views/view.xml
    cp $bpath/addon_squeleton/model.py $addon_name/models/model.py
}

function odoo_view_find_form() {
    model=$(echo $1 | sed 's/\./\\\./g')
    grep -RA 5 ">$model<" --include \*.xml | grep "<form" | greprl "" . | bsort
}

loaded odoo
