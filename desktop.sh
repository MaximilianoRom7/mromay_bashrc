import logging

function desktop_make_icon() {
    echo -n "New Application name ?: "
    read </dev/stdin appname
    appname=$(sed 's/ /_/g' <<< $appname)
    dest=$(echo ~/Desktop/"$appname".desktop)
    if [ -f $dest ]
    then
	echo "File '$dest' alredy exists"
	sleep 1
    else
	cp ~/mromay_bashrc/icon.desktop $dest
    fi
    vi $dest
    chmod +x $dest
}

loaded desktop
