#!/usr/bin/env bash

SCRIPTS=vagrant/setup

echo "Install full Lagrant package? (y/N) "
read inputInstall

if [ "${inputInstall}" = "y" ] ;
then
    echo "--- Init Install! ---"

    vagrant up

elif [ "${inputInstall}" = N ] ;
then

    ${SCRIPTS}/createdb.sh ${SCRIPTS}

    ${SCRIPTS}/gruntfile.sh ${SCRIPTS}

    ${SCRIPTS}/mysql-permissions.sh ${SCRIPTS}

    ${SCRIPTS}/vim-preferences.sh ${SCRIPTS}

    vagrant up

else

    echo "aborted! Invalid Entry. Please run setup.sh."

fi

