#!/bin/bash

enable_nginx () {

  # Enable Nginx
  if [ ! -f /etc/nginx/sites-enabled/app.conf ]; then
      echo "Enabling nginx..."
      rm -f /etc/service/nginx/down && \
          rm /etc/nginx/sites-enabled/default && \
          cp /home/app/webapp/docker/services/app/nginx/app.conf /etc/nginx/sites-enabled/
  fi
}

install_ruby_gems () {
  # Bundle install
  echo "Installing ruby gems..."
  cd /home/app/webapp && (bundle check || bundle install --jobs 4 --retry 6)
}

install_bower () {
  # Install bower
  echo "Installing bower globally..."
  npm -g install bower@1.7.9

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
  fi

  # Setup cron for periodic tasks
  if [ ! -f $HOME/cronfile ]; then
    cp /home/app/webapp/docker/services/ops/cronfile $HOME/
    crontab $HOME/cronfile
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
  else
      echo "Unknown service"
  fi

else
    echo "Unknown environment"
fi
