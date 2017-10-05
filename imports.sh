global_path=$home/mromay_bashrc


function import() {
    if [ ! "$(grep -o ' '$1' ' <<< $global_imports)" ]
    then
	global_imports=$global_imports" "$1" "
	. $global_path/$1.sh
    fi
}

import char
import path
import logging

function char_notspace_butlast() {
    : '
    example:
    char_notspace_butlast "a b c d" >>> "a b c"
    char_notspace_butlast "a b c d e" >>> "a b c d"
    '
    grep -oP ".*(?<= )" <<< "$@"
}

function import_name() {
    echo $@ | grep -oP "(?<=import )[^ ]+$"
}

function import_get_imports() {
    IFS=
    sources=$(grep -R "^import" $global_path)
    global_imports=" "
    while read l
    do
	v1=$(cut -d ':' -f1 <<< $l)
	v2=$(cut -d ':' -f2 <<< $l)
	file=$(path_no_ext $(path_last $v1))
	line=$(import_name $v2)
	global_imports=$(echo -e $global_imports$(echo $file" "$line | xargs)"\n ")
    done < <(echo $sources)
}

function import_test_circular() {
    if [ ! $global_imports ]
    then
	echo import_test_circular
	echo $global_imports
	import_get_imports
    fi
}

# import_test_circular
# loaded imports
