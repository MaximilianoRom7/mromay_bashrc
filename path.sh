function path_no_ext() {
    grep -oP "^[^\.]+" <<< $1
    
}
function path_last() {
    grep -oP "(?<=/)[^/]+$" <<< $1
}
