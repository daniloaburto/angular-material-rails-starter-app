#!/bin/bash

enable_nginx () {

  # Preserve environment variables
  # https://github.com/phusion/passenger-docker#setting-environment-variables-in-nginx
  if [ ! -f /etc/nginx/main.d/app-env.conf ]; then
    echo "Setting environment variables for nginx..."
    cp /home/app/webapp/docker/services/app/nginx/app-env.conf /etc/nginx/main.d/
  fi

  # Enable Nginx
  # https://github.com/phusion/passenger-docker#using-nginx-and-passenger
  if [ ! -f /etc/nginx/sites-enabled/app.conf ]; then
      echo "Enabling nginx..."
      rm -f /etc/service/nginx/down
      rm /etc/nginx/sites-enabled/default
      cp /home/app/webapp/docker/services/app/nginx/app.conf /etc/nginx/sites-enabled/
  fi
}

install_ruby_gems () {
  # Bundle install
  echo "Installing ruby gems..."
  cd /home/app/webapp && (bundle check || bundle install --jobs 4 --retry 6)
}

install_bower () {

  echo "Installing bower packages..."
  cd /home/app/webapp && bower install --allow-root
}

##
# Using "Backup" gem for database backup
# http://backup.github.io/backup/
##
setup_backups () {

  if [ ! -f $HOME/Backup/config.rb ]; then
    echo "Setting up backup gem..."

    mkdir -p $HOME/Backup/models/
    cp /home/app/webapp/docker/services/ops/backups/backup_database.rb $HOME/Backup/models/
    cp /home/app/webapp/docker/services/ops/backups/config.rb $HOME/Backup/

    # Setup cron for periodic tasks
    crontab /home/app/webapp/docker/services/ops/cronfile
    echo "crontab's return code: $?"
  fi
}

################################################
# PRODUCTION ENVIRONMENT
################################################
if [ "$ENV" = "production" ]
then

  if [ "$SERVICE" = "app" ]
  then
    # Do something
    echo "Init app..."
    enable_nginx

  elif [ "$SERVICE" = "sidekiq" ]
  then
    # Do something
    echo "Init sidekiq..."
  elif [ "$SERVICE" = "ops" ]
  then
    # Do something
    echo "Init ops..."
    setup_backups
  else
      echo "Unknown service"
  fi

################################################
# DEVELOPMENT ENVIRONMENT
################################################
elif [ "$ENV" = "development" ]
then

  if [ "$SERVICE" = "app" ]
  then
    # Do something
    echo "Init app..."
  elif [ "$SERVICE" = "sidekiq" ]
  then
    # Do something
    echo "Init sidekiq..."
  elif [ "$SERVICE" = "ops" ]
  then
    # Do something
    echo "Init ops..."

    install_ruby_gems
    install_bower
    setup_backups

    # Ok
    echo "################################"
    echo "#                              #"
    echo "#                              #"
    echo "#    OPS CONTAINER IS READY    #"
    echo "#                              #"
    echo "#                              #"
    echo "################################"
    echo "User: $USER"
    echo "Home: $HOME"
  else
      echo "Unknown service"
  fi

else
    echo "Unknown environment"
fi
