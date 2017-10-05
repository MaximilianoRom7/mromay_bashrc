. $home/mromay_bashrc/imports.sh
import logging

function python_package_path() {
    if [ $1 ]
    then
	python2 -c "import "$1"; print "$1".__file__"
    fi
}


loaded python
