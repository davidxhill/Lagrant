#!/usr/bin/env bash

SCRIPTS=$1

echo "Create database? (y/N) "
read create_db

if [ "${create_db}" = "y" ] ;
then
    echo "Please enter database name."
    read db_name

    if [ ! "${db_name}" = "" ]; then
        sed -i '' "s/DATABASE_NAME = 'lagrant'/DATABASE_NAME = '${db_name}'/" Vagrantfile
    fi

elif [ "${create_db}" = "N" ];
then
    echo "Create database set to false"
    sed -i '' "s/DATABASE_CREATE = true/DATABASE_CREATE = false/" Vagrantfile
else
   echo "invalid entry."
   ${SCRIPTS}/createdb.sh ${SCRIPTS}
fi

