ENV := development
DOCKERFILE := docker-compose.dev.yml
DOCKER_CONTAINER_NAME := rails_seed_app
DOCKER_HOST_IP := $(shell /sbin/ip route|awk '/default/ { print $$3 }')

#
clean_db:
	rake db:drop:all RAILS_ENV=$(ENV);		# Drop DB
	rake db:create RAILS_ENV=$(ENV);			# Create DB
	rake db:migrate RAILS_ENV=$(ENV);			# Create DB tables and relations - Used for version control

# Models
scaffold_models:
	rails g scaffold Country \
		name:string{255};

	rails g scaffold User \
		first_name:string{255} \
		last_name:string{255} \
		email:string{255} \
		enabled:boolean \
		role:integer{4};

	rails g scaffold Parameter \
		key:string{255} \
		value:string{255};

destroy_models:
	rails d scaffold Country;
	rails d scaffold User;
	rails d scaffold Parameter;

# Devise
enable_devise:
	rails generate devise User

# Policies
scaffold_policies:
	rails g pundit:policy country;
	rails g pundit:policy user;
	rails g pundit:policy parameter;

destroy_policies:
	rails d pundit:policy country;
	rails d pundit:policy user;
	rails d pundit:policy parameter;

# Database
create:
	# rake db:schema:load;	# Load db schema (Delete and Create empty DB)
	# rake db:drop:all;		# Drop DB
	rake db:create;			# Create DB if doesn't exists
	rake db:clear;			# Drop tables from environment related db
	rake db:migrate;		# Create tables and relations - Used for version control

seed:
	rake db:seed

scaffold: scaffold_models scaffold_policies
destroy: destroy_models destroy_policies
redo: destroy scaffold create seed

# Docker (dev only)
build:
	docker-compose -f $(DOCKERFILE) build

run:
	docker-compose -f $(DOCKERFILE) up

start:
	docker-compose -f $(DOCKERFILE) up -d

stop:
	docker-compose -f $(DOCKERFILE) stop

enter:
	docker exec -it $(DOCKER_CONTAINER_NAME) /bin/bash

# Inside docker's container
s: server
server:
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) rails s -b 0.0.0.0 -p 3000
