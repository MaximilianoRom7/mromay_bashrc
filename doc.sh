: '
  FUNCTIONS FOR BASH FUNCTION DOCUMENTATION
'
. $home/mromay_bashrc/imports.sh
import sort
import logging

# the maximum amount of lines the documentation can have
doc_max_doc_lines=50
# the maximum amount of lines the function can have
doc_max_func_lines=200

function doc_function() {
    : '
    GIVEN A FUNCTION NAME THIS FUNCTION WILL SEARCH FOR IT
    AND RETURN THE DOCUMENTATION IF EXISTS
    FOR EXAMPLE IF THE FUNCTION

    function grepc

    HAS THE FOLLOWING DOCUMENTATION BELLOW THE DEFINITION

    "GREPC IS A FUNCTION THAT ALWAYS RETURNS THE MATCH WITH COLORS AND USING LESS"

    THEN WHEN USING THIS FUNCTION LIKE THIS

    doc_function grepc

    WILL RETURN THE DOCUMENTATION OF THIS FUNCTION.
    '
    IFS=
    # 70 charactes width
    echo
    echo "----------------------------------------------------------------------"
    echo "    $1:"
    echo "----------------------------------------------------------------------"
    echo
    egrep -nR "^function $1\(\)" $home/mromay_bashrc | while read l
    do
	v1=$(cut -d ':' -f1 <<< $l)
	v2=$(cut -d ':' -f2 <<< $l)
	v3=$(($v2 + $doc_max_func_lines))
	docs=$(sed -n "$v2,$v3"p $v1 | sed -n '/function .*{/,/^}/p')
	v3=$(egrep -n "^}" <<< $docs | head -n 1 | cut -d ':' -f1)
	v3=$(( $v3 + $v2 - 2 ))
	v2=$(( $v2 + 1 ))
	docs=$(sed -n "$v2,$v3"p $v1)
	docs=$(echo $docs | sed -n "/: '$/,/'$/p")
	if [ "$docs" ]
	then
	    # 70 charactes width
	    echo $docs
	    echo
	    echo "----------------------------------------------------------------------"
	    echo
	fi
    done
}

function doc_list_functions() {
    egrep -R "^function [^ ]+\(\)" $home/mromay_bashrc | grep -oP "[^ ]+(?=\()" | bsort | while read l
    do
	doc_function $l
    done | less
}

loaded doc
