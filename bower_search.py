#!/usr/bin/python3
import sys
from subprocess import Popen, PIPE


def popenCom(command):
    return Popen(command.split(), stdout=PIPE, stderr=PIPE).communicate()


def search_package(package):
    """
    Esta funcion parsea el output del comando
    'bower search ${package}' para asi obtener la lista de
    paquetes que bower encuentra

    el comando retorna un formato como el siguiente:

    Search results:

        purescript-pux https://github.com/alexmingoia/purescript-pux.git
        purescript-js https://github.com/jqyu/purescript-js.git
        purescript-st https://github.com/purescript/purescript-st.git
        purescript-ws https://github.com/FruitieX/purescript-ws.git
    """
    command = 'bower search %s' % package
    stdout, stderr = popenCom(command)
    skipLines = 2
    output = []
    try:
        outLines = stdout.split(b'\n', skipLines)[skipLines]
        lines = outLines
        last = False
        while True:
            try:
                line, lines = lines.split(b'\n', 1)
            except:
                line = lines
                last = True
            pkgName = line[4:].split(b' ', 1)[0]
            if pkgName:
                output.append(str(pkgName, 'utf-8'))
            if last:
                break
    except Exception as e:
        sys.stderr.write(str(e))
    return output


def search_package_all(package):
    """
    Calls search_package recursively in order to find all the
    packages that match with the name 'package'
    """
    def recurSearch(package, pkgSearched, pkgNames, recurMax):
        pkgNames.update(search_package(package))
        pkgSearched.append(package)
        # list(map(print, pkgNames))
        if recurMax < 1:
            return pkgNames
        for pkgName in pkgNames.copy():
            if pkgName not in pkgSearched:
                pkgSearched.append(pkgName)
                newPkgNames = recurSearch(
                    pkgName, pkgSearched, pkgNames, recurMax - 1
                )
                pkgNames.update(newPkgNames)
        return pkgNames
    pkgSearched = []
    pkgNames = set()
    return list(recurSearch(package, pkgSearched, pkgNames, 5))


def install(package):
    """
    Installs a bower package
    """
    command = 'bower install %s' % package
    stdout, stderr = popenCom(command)
    print(str(stdout, 'utf-8'))


def search_package_all_install(package):
    """
    Installs every package that found bower
    """
    # pkgNames = search_package_all(package)
    pkgNames = open('./purescript_out', 'r').read().split('\n')
    for pkgName in pkgNames:
        install(pkgName)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit(1)
    package = sys.argv[1]
    # output = search_package(package)
    # output = search_package_all(package)
    output = search_package_all_install(package)
    # list(map(print, output))
