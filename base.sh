if [ -d ~/mromay_bashrc ]
then
    home=~
else
    home=/home/mromay
fi

. $home/mromay_bashrc/imports.sh
import logging
import char
import odoo
import docker
import json
import git
import files
import grep
import sort
import custom

loaded base
