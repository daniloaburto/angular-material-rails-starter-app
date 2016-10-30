FROM phusion/passenger-ruby22:0.9.15

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install bower
RUN npm -g install bower@1.7.9

# Config nginx
RUN rm -f /etc/service/nginx/down && \
    rm /etc/nginx/sites-enabled/default
ADD docker/nginx/nginx.conf /etc/nginx/sites-enabled/webapp.conf

# Add init scripts
ADD docker/my_init.d/*prod* /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*prod*

# Build web application
ADD . /home/app/webapp/
RUN bundle exec rake assets:precompile

# Change /home/app/webapp owner to user app
RUN sudo chown -R app:app /home/app/webapp/

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/[!bundle]* /var/tmp/*
