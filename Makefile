# Include environment variables from .env
include .env

init: create

#
clean_db:
	rake db:drop:all RAILS_ENV=$(ENV);	# Drop DB
	rake db:create RAILS_ENV=$(ENV);		# Create DB
	rake db:migrate RAILS_ENV=$(ENV);		# Create DB tables and relations - Used for version control

# Models
scaffold_models:
	bundle exec rails g scaffold Country \
		name:string{255};

	bundle exec rails g scaffold User \
		first_name:string{255} \
		last_name:string{255} \
		enabled:boolean \
		role:integer{4};

	bundle exec rails g scaffold Parameter \
		key:string{255} \
		value:string{255};

destroy_models:
	bundle exec rails d scaffold Country;
	bundle exec rails d scaffold User;
	bundle exec rails d scaffold Parameter;

# Devise
enable_devise:
	bundle exec rails generate devise:install
	bundle exec rails generate devise User

disable_devise:
	bundle exec rails destroy devise:install
	bundle exec rails destroy devise User

# Policies
scaffold_policies:
	bundle exec rails g pundit:policy country;
	bundle exec rails g pundit:policy user;
	bundle exec rails g pundit:policy parameter;

destroy_policies:
	bundle exec rails d pundit:policy country;
	bundle exec rails d pundit:policy user;
	bundle exec rails d pundit:policy parameter;

# Database
create:
	# rake db:schema:load;	# Load db schema (Delete and Create empty DB)
	# rake db:drop:all;		# Drop DB
	rake db:create;			# Create DB if doesn't exists
	rake db:clear;			# Drop tables from environment related db
	rake db:migrate;		# Create tables and relations - Used for version control

seed:
	rake db:seed

scaffold: scaffold_models scaffold_policies enable_devise
destroy: disable_devise destroy_models destroy_policies
redo: destroy scaffold create seed

# Docker (dev only)
build:
	docker-compose build

run:
	docker-compose up

start:
	docker-compose up -d

stop:
	docker-compose stop

enter:
	docker exec -it $(APP_CONTAINER_NAME) /bin/bash

enter-sidekiq:
	docker exec -it $(SIDEKIQ_CONTAINER_NAME) /bin/bash

enter-ops:
	docker exec -it $(OPS_CONTAINER_NAME) /bin/bash

# Inside docker's container
s: server
server:
	$(eval DOCKER_HOST_IP := $(shell /sbin/ip route|awk '/default/ { print $$3 }'))
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) bundle exec rails s -b 0.0.0.0 -p 3000

sq: sidekiq
sidekiq:
	$(eval DOCKER_HOST_IP := $(shell /sbin/ip route|awk '/default/ { print $$3 }'))
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) bundle exec sidekiq -e $(ENV) -c $(SIDEKIQ_CONCURRENCY)
