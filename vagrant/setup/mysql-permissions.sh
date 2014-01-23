#!/usr/bin/env bash

SCRIPTS=$1

echo "Set mysql permissions to allow for a standard contection to the database.  (y,N)"
read set_mysql

if [ "${set_mysql}" = "y" ] ;
then
    echo "Set mysql permissions to true"
elif [ "${set_mysql}" = "N" ];
then
    echo "Set mysql permission to false"
    sed -i '' "s/EDIT_PERMISSIONS = true/EDIT_PERMISSIONS = false/" Vagrantfile
else
   echo "invalid entry."
   ${SCRIPTS}/mysql-permissions.sh ${SCRIPTS}
fi

