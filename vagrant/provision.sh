#!/usr/bin/env bash

 #TODO!
 #mariadb
 #postgresql
 #xhprof
 #ruby
 #bower
 #grunt
 #less
 #YUI compressor
 #coffeescript
 #DART
 #apache

SCRIPTS=/vagrant/vagrant/scripts
PROJECT_PATH=/vagrant

ENV_NAME=$1
EDIT_PERMISSIONS=$2
CREATE_GRUNT=$3
CREATE_BOWER=$4
SET_VIM_PREFERENCES=$5
DATABASE_TYPE=$6
DATABASE_ROOT_PASSWORD=$7
DATABASE_NAME=$8

echo "--- Setting up system ---"

${SCRIPTS}/init.sh $ENV_NAME

${SCRIPTS}/php.sh

 #web server MUST be installed immediately after PHP
${SCRIPTS}/nginx.sh

${SCRIPTS}/documentroot.sh

${SCRIPTS}/${DATABASE_TYPE}.sh $DATABASE_ROOT_PASSWORD

${SCRIPTS}/nodejs.sh

${SCRIPTS}/bower.sh

${SCRIPTS}/grunt.sh
${SCRIPTS}/grunt-autoprefixer.sh

${SCRIPTS}/coffeescript.sh

${SCRIPTS}/ruby.sh

${SCRIPTS}/imagick.sh

${SCRIPTS}/xdebug.sh

${SCRIPTS}/phpunit.sh

${SCRIPTS}/sass.sh

${SCRIPTS}/composer.sh

${SCRIPTS}/beanstalkd.sh

# Temp Removal
#${SCRIPTS}/phantomjs.sh
#${SCRIPTS}/less.sh
#${SCRIPTS}/redis.sh
#${SCRIPTS}/mongodb.sh


if [ -n "$DATABASE_NAME" ];
then
    ${SCRIPTS}/${DATABASE_TYPE}_createdb.sh $DATABASE_NAME $DATABASE_ROOT_PASSWORD
fi

 #We assume that if there is no composer.json it is raw new project
 #Otherwise project already exists and we need to migrate it

if [ ! -a "/vagrant/composer.json" ];
then
    ${SCRIPTS}/laravel_create.sh $PROJECT_PATH $ENV_NAME
    if [ -n "$DATABASE_NAME" ];
    then
        ${SCRIPTS}/laravel_set_db.sh $PROJECT_PATH $ENV_NAME $DATABASE_TYPE $DATABASE_NAME $DATABASE_ROOT_PASSWORD
    fi
    #removing longggg load creation time for testing
    ${SCRIPTS}/laravel_packages.sh $PROJECT_PATH $ENV_NAME
else
    ${SCRIPTS}/laravel_migrate.sh $PROJECT_PATH $ENV_NAME
fi

# Setting mysql permissions if true
if [ "${EDIT_PERMISSIONS}" = "true" ];
then
    ${SCRIPTS}/mysql_permission.sh
    echo 'mysql permissions set;'
fi

# Setting Package and Gruntfile if true
if [ ! -f /vagrant/Gruntfile.js ] && [ "${CREATE_GRUNT}" = 'true' ] ;
then

    if [ ! -f "/vagrant/package.json" ] ;
    then 
        ${SCRIPTS}/node_package_setup.sh
    fi

    ${SCRIPTS}/grunt_setup.sh
fi

# Setting Vim Preferences if true
if [ ! -f /home/vagrant/.vimrc.local ] && [ ${SET_VIM_PREFERENCES} = 'true' ] ;
then
    ${SCRIPTS}/vim.sh
fi

