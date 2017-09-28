. ~/mromay_bashrc/imports.sh
import logging

function docker_restart_odoo() {
    sudo systemctl reload odoo-1
    sudo systemctl reload odoo-2
    sudo systemctl reload odoo-3
    sudo systemctl reload odoo-4
    sudo systemctl reload odoo-5
}

loaded docker
