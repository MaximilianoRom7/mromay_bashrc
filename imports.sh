global_path=~/mromay_bashrc
# . $global_path/char.sh
. $global_path/path.sh


function char_notspace_butlast() {
    : '
    example:
    char_notspace_butlast "a b c d" >>> "a b c"
    char_notspace_butlast "a b c d e" >>> "a b c d"
    '
    grep -oP ".*(?<= )" <<< "$@"
}

function import_name() {
    echo $@ | grep -oP "(?<=import )[^ ]+$" | xargs
}

function import_get_imports() {
    IFS=
    sources=$(grep -r "^import" $global_path)
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
    import_get_imports
}

function import() {
    . $global_path/$1.sh
}

if [ ! $global_imports ]
then
    import_test_circular
    echo import_test_circular
    # echo $global_imports
fi
