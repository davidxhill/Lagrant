#!/usr/bin/env bash

SCRIPTS=$1

echo "Include default Gruntfile.js(watch, sass, concat, uglify, phpunit)? (y,N)"
read create_grunt

if [ "${create_grunt}" = "y" ] ;
then
    echo "Create Gruntfile.js set to true"
elif [ "${create_grunt}" = "N" ];
then
    echo "Create Gruntfile.js set to false"
    sed -i '' "s/CREATE_GRUNT = true/CREATE_GRUNT = false/" Vagrantfile
else
   echo "invalid entry."
   ${SCRIPTS}/gruntfile.sh ${SCRIPTS}
fi

