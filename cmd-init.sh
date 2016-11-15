#!/bin/bash

WEBAPP="/home/app/webapp"
SERVICE=app

# Create
echo "Creating database..."
docker-compose run --rm $SERVICE /bin/bash -l -c "RAILS_ENV=production $WEBAPP/bin/rake db:create:all"

# Migrate
echo "Migrating..."
docker-compose run --rm $SERVICE /bin/bash -l -c "RAILS_ENV=production $WEBAPP/bin/rake db:migrate"

# Init db
# echo "Intitializing database..."
# docker-compose run --rm $SERVICE /bin/bash -l -c "RAILS_ENV=production $WEBAPP/bin/rake db:seed"
