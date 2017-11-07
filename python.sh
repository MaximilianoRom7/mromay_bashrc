. $home/mromay_bashrc/imports.sh
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
    python <<EOF
import $1
attrs=dir($1);
fil=lambda x: x[0] == '_' and x[-1] == '_' and not 'builtin' in x;
attrs=filter(fil, attrs);
vals=zip(attrs, map(lambda x: getattr($1, x), attrs));
vals=dict(filter(bool, map(lambda x: x if x[1] else False, vals)));
from json import dumps;
print dumps(vals, indent=4)
EOF
}

loaded python
