#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Add Laravel dev packcages ---"

################################
# update composer.json
################################

cd ${PROJECT_PATH}

# while package-installer is not compatible with L4.1, comment it
# composer require --no-update rtablada/package-installer:dev-master

composer require --dev --no-update way/generators:dev-master way/laravel-test-helpers:dev-master barryvdh/laravel-ide-helper:1.*
composer require --dev --no-update fzaninotto/faker:dev-master codeception/codeception:* 
composer require --dev --no-update phpunit/phpunit:3.7.*
composer require --dev --no-update itsgoingd/clockwork:dev-master

# changing timeout...had issues on lower internet connections
COMPOSER_CONFIG_ANCHOR='"config": {'
COMPOSER_CONFIG_REPLACE_STR=$COMPOSER_CONFIG_ANCHOR"\n"'            "COMPOSER_PROCESS_TIMEOUT":600'
sed -i "s/$COMPOSER_CONFIG_ANCHOR/$COMPOSER_CONFIG_REPLACE_STR" composer.json

composer update --prefer-dist

################################
# update configs
################################

# this will update main config and add package installer provider

cd ${PROJECT_PATH}/app/config

################################
# setting serviceProviders
################################

REPLACE_ANCHOR="'Illuminate\\\Workbench\\\WorkbenchServiceProvider',"

REPLACE_STR=$REPLACE_ANCHOR"\n\n        'Way\\\Generators\\\GeneratorsServiceProvider',\n\n       'Clockwork\\\Support\\\Laravel\\\ClockworkServiceProvider',"
sed -i "s/$REPLACE_ANCHOR/$REPLACE_STR/" app.php

################################
# setting facades
################################

REPLACE_ANCHOR_ALIASES="=> 'Illuminate\\\Support\\\Facades\\\View',"
REPLACE_STR_ALIASES=$REPLACE_ANCHOR_ALIASES"\n       'Clockwork' => 'Clockwork\\\Support\\\Laravel\\\Facade',"
sed -i "s/$REPLACE_ANCHOR_ALIASES/$REPLACE_STR_ALIASES/" app.php

################################
# create a start file for development environment
################################

cd ${PROJECT_PATH}/app/start
echo -e '<?php\n' > ${ENV_NAME}.php

################################
# register providers via start file (see https://github.com/laravel/framework/issues/1603#issuecomment-21864164)
################################

echo "App::register('Way\\Generators\\GeneratorsServiceProvider');" >> ${ENV_NAME}.php
echo "App::register('Barryvdh\\LaravelIdeHelper\\IdeHelperServiceProvider');" >> ${ENV_NAME}.php

echo -e '\n' >> ${ENV_NAME}.php

cd ${PROJECT_PATH}
composer dump-autoload -o

################################
# register aliases
################################
# not need now, but left as a snippet
# echo "\$loader = \\Illuminate\\Foundation\\AliasLoader::getInstance();" >> ${ENV_NAME}.php
# echo "\$loader->alias('Profiler', 'Profiler\\Facades\\Profiler');" >> ${ENV_NAME}.php

################################
# set up environment detection
################################

cd ${PROJECT_PATH}/bootstrap
sed -i "s/'your-machine-name'/'${ENV_NAME}'/" ./start.php
if [ $ENV_NAME != 'local' ]; then
    sed -i "s/'local'/'${ENV_NAME}'/" ./start.php
fi

################################
# generate IDE helper
################################

cd ${PROJECT_PATH}
php artisan clear-compiled --env="${ENV_NAME}"
php artisan ide-helper:generate --env="${ENV_NAME}"
php artisan optimize --env="${ENV_NAME}"
