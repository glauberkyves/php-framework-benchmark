#!/bin/sh

composer install --no-dev --optimize-autoloader
chmod o+w storage/*
sudo chmod o+w storage/framework/*
php artisan config:cache
#php artisan route:cache
