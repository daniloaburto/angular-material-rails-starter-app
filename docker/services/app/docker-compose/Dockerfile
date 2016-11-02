FROM phusion/passenger-ruby22:0.9.15

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV BUNDLE_PATH /home/app/webapp/vendor/bundle

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Build web application
ADD . /home/app/webapp/

# Add init scripts
# RUN cp /home/app/webapp/docker/services/app/my_init.d/*prod* /etc/my_init.d/
# RUN chmod +x /etc/my_init.d/*prod*

# Config nginx
RUN rm -f /etc/service/nginx/down && \
    rm /etc/nginx/sites-enabled/default && \
    cp /home/app/webapp/docker/services/app/nginx/app.conf /etc/nginx/sites-enabled/

# Change /home/app/webapp owner to user app
RUN sudo chown -R app:app /home/app/webapp/
WORKDIR /home/app/webapp/

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*
