FROM daniloaburto/rails-seed-base:latest

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV BUNDLE_PATH /home/app/webapp/vendor/bundle

# Add init scripts
# RUN cp /home/app/webapp/docker/my_init.d/*app_prod* /etc/my_init.d/
# RUN chmod +x /etc/my_init.d/*app_prod*

# Config nginx
RUN rm -f /etc/service/nginx/down && \
    rm /etc/nginx/sites-enabled/default && \
    cp /home/app/webapp/docker/services/app/nginx/app.conf /etc/nginx/sites-enabled/

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*
