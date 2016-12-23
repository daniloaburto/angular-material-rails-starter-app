#!/bin/bash

WEBAPP="/home/app/webapp"
SERVICE=app

# Migrate
echo "Migrating..."
docker-compose run --rm $SERVICE /bin/bash -l -c "RAILS_ENV=production $WEBAPP/bin/rake db:seed"
