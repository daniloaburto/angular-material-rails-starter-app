FROM daniloaburto/rails-seed-base:latest

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV BUNDLE_PATH /home/app/webapp/vendor/bundle

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Add init scripts
# RUN cp /home/app/webapp/docker/services/sidekiq/my_init.d/*prod* /etc/my_init.d/
# RUN chmod +x /etc/my_init.d/*prod*

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*
