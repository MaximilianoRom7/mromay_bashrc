. ~/mromay_bashrc/imports.sh
import logging

function char_count() {
	echo $@ | grep -o '.' | wc -l
}


loaded char
