FROM phusion/passenger-ruby22:0.9.15

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV BUNDLE_PATH /home/app/webapp/vendor/bundle

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install gems in a cache efficient way
WORKDIR /home/app/webapp/
ADD Gemfile /home/app/webapp/
ADD Gemfile.lock /home/app/webapp/
RUN bundle install --jobs 4 --retry 6 --deployment --without development test

# Install bower
RUN npm -g install bower@1.7.9
RUN bower install --allow-root

# Add files
ADD . /home/app/webapp/

# Change /home/app/webapp owner to user app
RUN sudo chown -R app:app /home/app/webapp/
WORKDIR /home/app/webapp/

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*
