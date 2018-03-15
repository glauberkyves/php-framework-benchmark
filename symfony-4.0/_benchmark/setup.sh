#!/bin/sh

export MAILER_URL=null://localhost
export APP_ENV=prod
export APP_DEBUG=0
export APP_SECRET=ODtvoHW6pn3bE2rHgTa2MjkjwefzlsJH
composer install --no-dev --optimize-autoloader
php bin/console cache:clear --env=prod --no-debug
chmod o+w var/cache/ var/logs/
chmod -R o+w var/cache/*
