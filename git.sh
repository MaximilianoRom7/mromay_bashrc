. ~/mromay_bashrc/imports.sh
import path

local_git_github_user_repos=https://api.github.com/users/*/repos

function git_clone_repos_user() {
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
	if [ ! -d $d ]
	then
	    git clone $l
	fi
	cd $d
	git fetch
	cd ..
    done < <(echo $urls)
    cd ..
}
