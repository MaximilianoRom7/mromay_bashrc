. ~/mromay_bashrc/imports.sh
import vars

function loaded() {
    if [ $global_logging ]
    then
	echo "loaded "$1
    fi
}

loaded logging
