. ~/mromay_bashrc/imports.sh
import vars

function loaded() {
    if [ $global_logging ]
    then
	echo "custom "$1" loaded ..."
    fi
}

loaded logging
