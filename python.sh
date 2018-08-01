import logging

function python_package_path() {
    : '
    IF YOU WANT TO KNOW THE PATH OF A PYTHON PACKAGE
    USE THIS FUNCTION IN THE FOLLOWING MANNER

    python_package_path json

    WILL RETURN

    /usr/lib/python2.7/json
    '
    if [ $1 ]
    then
	dirname $(python2 -c "import "$1"; print "$1".__file__") 2> /dev/null
    fi
}

function python_defs() {
    egrep -R "^[ \t]+def [^ ]+):" --include \*.py 2> /dev/null
}

function python_package_info() {
    if [ ! "$1" ]
    then
	echo "You have to provide a python package name"
	return 1
    fi
    if [ "$2" == "full" ]
    then
	python <<EOF
import $1;
attrs=dir($1);
fil=lambda x: x[0] == '_' and x[-1] == '_' and not 'builtin' in x;
attrs=filter(fil, attrs);
vals=zip(attrs, map(lambda x: getattr($1, x), attrs));
vals=dict(filter(bool, map(lambda x: x if x[1] else False, vals)));
from json import dumps;
print dumps(vals, indent=4)
EOF
    else
	python <<EOF
import $1;
attrs=dir($1);
vals={};
func=lambda x, y, z: x.update({z: str(getattr(y, z))[:100]}) if hasattr(y, z) else False;
func(vals, $1, '__author__');
func(vals, $1, '__build__');
func(vals, $1, '__date__');
func(vals, $1, '__file__');
func(vals, $1, '__name__');
func(vals, $1, '__package__');
func(vals, $1, '__path__');
func(vals, $1, '__version__');
func(vals, $1, '__VERSION__');
from json import dumps;
print dumps(vals, indent=4)
EOF
    fi
}

function python_packages() {
    pip list | cut -d ' ' -f1
}

function python_packages_info() {
    python_packages | while read l
    do
	python_package_info $l $1
    done 2> /dev/null
}

function python_list() {
    : '
    MAKE A PYTHON LIST FROM MULTIPLE LINES
    '
    echo "[ "$(paste -s -d"," <<< $1)" ]"
}

function js_func_sort() {
    : '
    GIVEN A JS FILE RETURNS THE ORDER THAT THE FUNCTIONS SHOULD APPEAR
    '
    IFS=
    s=$(cat $1)
    ll=$(egrep ": function.*{" <<< "$s" | grep -oP "[^ \t]+(?=:)")
    m=$(python_list \
	    $(echo $ll | while read l
	      do
		  n=$(egrep -n "$l" <<< "$s" | egrep -v ": function" | cut -d ':' -f 1 | head -n 1)
		  if [ ! "$n" ]
		  then
		      n="-1"
		  fi
		  python_list $(echo -e '"'$l'"'"\n$n")
	      done
	    ))
    python <<EOF
l=$m
l1 = filter(lambda x: x[1] > 0, l)
l2 = filter(lambda x: x[1] < 0, l)
l1.sort(key=lambda a: a[1])
l1 = map(lambda x: x[0], l1)
l2 = map(lambda x: x[0], l2)
for n in l1 + l2:
    print n
EOF
}

function python_import {
    python2 <<EOF
import $1
print $1.__file__
EOF
}

loaded python
