#!/usr/bin/env bash

SCRIPTS=$1

echo "Set vim Preferences?  (y,N)"
read set_vim

if [ "${set_vim}" = "y" ] ;
then
    echo "Set vim permissions to true"
elif [ "${set_vim}" = "N" ];
then
    echo "Set vim permission to false"
    sed -i '' "s/SET_VIM_PREFERENCES = true/SET_VIM_PREFERENCES = false/" Vagrantfile
else
   echo "invalid entry."
   ${SCRIPTS}/vim-preferences.sh ${SCRIPTS}
fi

