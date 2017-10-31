HOW TO USE:


In your user home directory "~" (/home/<user>)


do git clone <This_Repo_Url>


And


In the file ~/.bashrc add the following line at the end of this file


. ~/mromay_bashrc/base.sh

This loads the entire source of this bash library with all the functions

To charge the functions is necessary to write source ~/.bashrc

The explanations of each one is in the file, after the definition of the function. 

For example, in the file odoo.sh are the functions for handeling odoo.


Which functions ?


Now there are more than 50 different

Functions from grep, to docker, to odoo, to python, to git, ext.

These are utilities to help you search data and other things.


Functions like:


For odoo:

    odoo_services_test_load

    odoo_services_watch

    odoo_addons_change_version

    odoo_addons_change_versions

    odoo_addons_versions

    odoo_fields_find

    odoo_models

    odoo_view_search

    odoo_view_models

    odoo_find_addons_folders

    odoo_find_odoos

    odoo_kill

    odoo_choose_addons_folder


For python:

    python_package_path

    python_defs
