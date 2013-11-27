#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Add Laravel dev packcages ---"

# update composer.json

cd ${PROJECT_PATH}
composer require --no-update rtablada/package-installer:dev-master
composer require --dev --no-update loic-sharma/profiler:1.1.* way/generators:dev-master way/laravel-test-helpers:dev-master barryvdh/laravel-ide-helper:1.*
composer require --dev --no-update fzaninotto/faker:dev-master codeception/codeception:* phpunit/phpunit=3.7.*
composer update --prefer-source

# update configs

cd ${PROJECT_PATH}/app/start

# create a start file for development environment
echo -e '<?php\n' > ${ENV_NAME}.php

# register providers via start file (see https://github.com/laravel/framework/issues/1603#issuecomment-21864164)
echo "App::register('Way\\Generators\\GeneratorsServiceProvider')->boot();" >> ${ENV_NAME}.php
echo "App::register('Profiler\\ProfilerServiceProvider')->boot();" >> ${ENV_NAME}.php
echo "App::register('Barryvdh\\LaravelIdeHelper\\IdeHelperServiceProvider')->boot();" >> ${ENV_NAME}.php

echo -e '\n' >> ${ENV_NAME}.php

# register aliases
echo "\$loader = \\Illuminate\\Foundation\\AliasLoader::getInstance();" >> ${ENV_NAME}.php
echo "\$loader->alias('Profiler', 'Profiler\\Facades\\Profiler');" >> ${ENV_NAME}.php

# publish packages configs

cd ${PROJECT_PATH}

php artisan config:publish loic-sharma/profiler --env="${ENV_NAME}"
php artisan config:publish barryvdh/laravel-ide-helper --env="${ENV_NAME}"

# generate IDE helper

php artisan clear-compiled --env="${ENV_NAME}"
php artisan ide-helper:generate --env="${ENV_NAME}"
php artisan optimize --env="${ENV_NAME}"