# delete variable so it reloads all the imports
global_imports=

if [ -d ~/mromay_bashrc ]
then
    home=~
else
    home=/home/mromay
fi

bpath=$home/mromay_bashrc

IFS=

. $home/mromay_bashrc/imports.sh
import logging
import profile
import char
import odoo
import docker
import json
import git
import files
import grep
import sort
import custom
import reloading
import process
import python
import split
import filter
import doc
import math
import eval
import check
import net
import list
import message
import program
import find
import video
import ssh
import watch
import service
import desktop
import test

loaded base
