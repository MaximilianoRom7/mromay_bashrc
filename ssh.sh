import logging

function ssh_hosts() {
    grep -C 10 "$@" ~/.ssh/config
}

loaded ssh
