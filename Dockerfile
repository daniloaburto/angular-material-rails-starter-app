FROM phusion/passenger-ruby22:0.9.15

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV BUNDLE_PATH /home/app/webapp/vendor/bundle

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Workdir for bundle and bower
WORKDIR /home/app/webapp/

# PG Client for ops container
RUN apt-get update && apt-get install -y postgresql-client-9.3

# Backups for ops container
RUN gem install backup -v 4.2.3

# Install gems in a cache efficient way
ADD Gemfile /home/app/webapp/
ADD Gemfile.lock /home/app/webapp/
RUN bundle install --jobs 4 --retry 6 --deployment --without development test

# Install bower in a cache efficient way
ADD .bowerrc /home/app/webapp/
ADD bower.json /home/app/webapp/
RUN npm -g install bower@1.7.9
RUN bower install --allow-root

# Add files
ADD . /home/app/webapp/

# Change /home/app/webapp owner to user app
RUN sudo chown -R app:app /home/app/webapp/

# Add init script
ADD docker/my_init.d/*.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*.sh

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*
