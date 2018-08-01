import logging

function db_query_to_file() {
    if [ $3 ]
    then
        db_out_file=$3
    else
        db_out_file=out.json
    fi
    psql -d $1 -t -A -F"," -c $2 > $db_out_file
    less $db_out_file
}

function db_query_to_json() {
    db_query_to_file $1 "select json_agg(t) from ($2) t;" $3
}

function odoo_connections_json() {
    connections_json="connections.json"
    connections_query="select * from afipws_connection"
    db_query_to_json $1 $connections_query $connections_json
}


loaded database
