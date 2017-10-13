: '
  FUNCTIONS FOR BASH FUNCTION DOCUMENTATION
'
. $home/mromay_bashrc/imports.sh
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
	echo $docs | sed -n "/: '$/,/'$/p"
    done
}

loaded doc
