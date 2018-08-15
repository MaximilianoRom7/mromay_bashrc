import logging

function curl_put() {
    if [ "$2" ]
    then
        curl -X PUT -H "Content-Type: application/json" -d "$1" "$2"
    else
        echo "Need two arguments"
    fi
}

function curl_post() {
    if [ "$2" ]
    then
        curl -X POST -H "Content-Type: application/json" -d "$1" "$2"
    else
        echo "Need two arguments"
    fi
}


loaded curl
