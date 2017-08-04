#!/bin/bash

# Install Newrelic extension
if [ "$APP_ENVIRONMENT" != "dev" ] && [ "$APP_REGION" != "us1" ]
then
	sed -i 's/^;\(newrelic\.license = "\).*\("\)/\1'$NEWRELIC_KEY'\2 /' /usr/local/etc/php/conf.d/newrelic.ini
	sed -i 's/^\(newrelic\.appname = "\).*\("\)/\1API ('$APP_DEPLOY_ENV')\2 /' /usr/local/etc/php/conf.d/newrelic.ini
	sed -i 's/^;\(newrelic\.labels = "\).*\("\)/\1Environment:'$APP_DEPLOY_ENV'\2 /' /usr/local/etc/php/conf.d/newrelic.ini
	cp /usr/local/etc/php/conf.d/newrelic.ini /usr/local/etc/php-fpm.d/
else
	/bin/rm -f /usr/local/etc/php/conf.d/newrelic.ini
fi

# Exec php-fpm
exec php-fpm