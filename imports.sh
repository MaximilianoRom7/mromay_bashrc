global_path=~/mromay_bashrc
. $global_path/path.sh

function import_name() {
    grep -oP "(?<=import )[^ ]+$" <<< $1
}

function import_test_circular() {
    IFS=
    sources=$(grep -r "^import" $global_path)
    global_imports=" "
    while read l
    do
	v1=$(cut -d ':' -f1 <<< $l)
	v2=$(cut -d ':' -f2 <<< $l)
	file=$(path_no_ext $(path_last $v1))
	line=$(import_name $v2)
	global_imports=$(echo -e $global_imports$file" "$line"\n ")
    done < <(echo $sources)
}

function import() {
    . $global_path/$1.sh
}

if [ ! $global_imports ]
then
    import_test_circular
    echo import_test_circular
    echo $global_imports
fi
