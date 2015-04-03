#!/bin/sh

if [ ! `which composer` ]; then
    echo "composer command not found."
    exit 1;
fi

if [ ! `which ab` ]; then
    echo "ab command not found."
    exit 1;
fi

if [ ! `which curl` ]; then
    echo "curl command not found."
    exit 1;
fi

# Yii 2.0 requires composer-asset-plugin
composer global require "fxp/composer-asset-plugin:1.0.0-beta3"

cd yii-2.0
composer install --no-dev
chmod o+w assets/ runtime/ web/assets/

cd ../fuel-1.8-dev
composer install --prefer-source --no-dev

cd ../laravel-4.2
composer install --no-dev --optimize-autoloader
chmod o+w app/storage/*

cd ../cake-3.0
sudo rm -rf tmp/*
COMPOSER_PROCESS_TIMEOUT=3600 composer install --no-dev

cd ../symfony-2.5
export SYMFONY_ENV=prod
composer install
chmod o+w app/cache/ app/logs/
chmod -R o+w app/cache/*

cd ../symfony-2.6
export SYMFONY_ENV=prod
composer install
chmod o+w app/cache/ app/logs/
chmod -R o+w app/cache/*

cd ../phalcon-1.3
chmod o+w app/cache/

cd ../bear-0.10
composer install --no-dev --optimize-autoloader
chmod o+w var/tmp/ var/log/

cd ../bear-1.0
composer install --no-dev --optimize-autoloader
chmod o+w var/tmp/ var/log/

cd ../laravel-5.0
composer install --no-dev --optimize-autoloader
chmod o+w storage/*
chmod o+w storage/framework/*
php artisan optimize --force
php artisan config:cache
php artisan route:cache

cd ../fuel-2.0-dev
composer install --no-dev
chmod o+w components/demo/cache/ components/demo/logs/

cd ../silex-1.2
composer install --no-dev --optimize-autoloader

cd ../slim-2.6
composer install --no-dev --optimize-autoloader

cd ../zf-2.4
composer install --no-dev

cd ../typo3-flow-2.3
export FLOW_CONTEXT=Production
composer install --no-dev --optimize-autoloader
./flow flow:cache:warmup
sed -i -e 's/{ exit(); }/{ echo "\n" . (memory_get_peak_usage(true)\/1024\/1024); exit(); };/' Packages/Framework/TYPO3.Flow/Classes/TYPO3/Flow/Http/RequestHandler.php
