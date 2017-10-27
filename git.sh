. $home/mromay_bashrc/imports.sh
import path
import logging

local_git_github_user_repos=https://api.github.com/users/*/repos

function git_clone_repos_user() {
    : '
    Given a user name clone all the repositories
    from the github account
    for example the user ingadhoc has this repositories

        ./account-analytic/
        ./account-financial-tools/
        ./account-invoicing/
        ./account-payment/
        ./adhoc-rancher/
        ./aeroo/

    so:
    git_clone_repos_user ingadhoc

    will create a copy for each one in a folder with that username
    '
    IFS=
    # create folder for user
    if [ ! -d "$1" ]
    then
	mkdir $1
    fi
    if [ ! $? -eq 0 ]
    then
	echo "error creating folder"
	return 1
    fi
    cd $1
    url=$(sed 's/*/'$1'/g' <<< $local_git_github_user_repos)
    body=$(curl $url 2> /dev/null)
    urls=$(egrep "\"clone_url\": " <<< $body)
    urls=$(grep -oP "(?<=\")[^\"]+(?=\",)" <<< $urls)
    while read l
    do
	d=$(path_no_ext $(path_last $l))
	# do not clone the entirey odoo repository is too big
	# and we alredy have it
	if [ ! $(egrep "^odoo$" <<< $d) ]
	    then
	    if [ ! -d $d ]
	    then
	        git clone $l
	    fi
	    cd $d
	    echo
	    echo git fetch $l
	    git fetch $l
	    cd ..
	fi
    done < <(echo $urls)
    cd ..
}

function git_list_repos() {
    : '
    FIND ALL GIT REPOSITORIES IN THE CURRENT PATH
    '
    findd | grep -oP "^.*(?=/\.git$)"
}

function git_versions() {
    : '
    THIS FUNCTION RETURNS THE GIT HASH VERSION
    OF ALL THE REPOSITORY FROM THE CURRENT PATH
    '
    IFS=
    w=$(pwd)
    git_list_repos | while read l
    do
	cd $l
	echo $l $(git rev-parse --verify HEAD)
	cd $w
    done
    cd $w
}

function git_versions_diff() {
    : '
    GIVEN TWO FILE PATHS THAT ARE THE RESULT
    FROM THE "git_versions" FUNCTION, THIS FUNCTION RETURNS
    THE LIST OF REPOSITORIES THAT DIFFER ON THE GIT HASH VERSION
    '
    IFS=
    if [ "$2" ]
    then
	f1=$(cat "$1")
	f2=$(cat "$2")
    else
	echo "You Must pass two file paths to compare versions"
	return 1
    fi
    echo $f1 | while read l
    do
	l1=$(cut -d ' ' -f1 <<< $l)
	v1=$(cut -d ' ' -f2 <<< $l)
	l2=$(egrep "^$l1 "<<< $f2 | head -n 1)
	if [ "$l2" ]
	then
	    v2=$(cut -d ' ' -f2 <<< $l2)
	    if [ ! "$v1" == "$v2" ]
	    then
		echo $l1 $v1 $v2
	    fi
	else
	    echo "NOT FOUND: "$l1
	fi
    done
}

loaded git
