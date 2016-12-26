# Include environment variables from .env
include .env

# Colors
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m # No Color

# If code is executed inside a container
ifneq ($(wildcard /.dockerenv),)
	DOCKER_HOST_IP := $(shell /sbin/ip route|awk '/default/ { print $$3 }')
else
	DOCKER_APP_CONTAINER_ID := $(shell docker ps --filter="name=$(APP_CONTAINER_NAME)" -q)
	DOCKER_SIDEKIQ_CONTAINER_ID := $(shell docker ps --filter="name=$(SIDEKIQ_CONTAINER_NAME)" -q)
	DOCKER_OPS_CONTAINER_ID := $(shell docker ps --filter="name=$(OPS_CONTAINER_NAME)" -q)
endif

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

build:
ifeq ($(wildcard /.dockerenv),)
	docker-compose build
endif

run:
ifeq ($(wildcard /.dockerenv),)
	docker-compose up
endif

start:
ifeq ($(wildcard /.dockerenv),)
	docker-compose up -d
endif

stop:
ifeq ($(wildcard /.dockerenv),)
	docker-compose stop
endif

restart:
ifeq ($(wildcard /.dockerenv),)
	docker-compose restart
endif

enter:
	docker exec -it $(APP_CONTAINER_NAME) /bin/bash -l

enter-sidekiq:
	docker exec -it $(SIDEKIQ_CONTAINER_NAME) /bin/bash -l

enter-ops:
	docker exec -it $(OPS_CONTAINER_NAME) /bin/bash -l

status:
ifeq ($(wildcard /.dockerenv),)
ifeq ($(DOCKER_APP_CONTAINER_ID),)
	@echo "$(RED)APP container is not running$(NC)"
else
	@echo "$(GREEN)APP container is running$(NC)"
endif

ifeq ($(DOCKER_SIDEKIQ_CONTAINER_ID),)
	@echo "$(RED)SIDEKIQ container is not running$(NC)"
else
	@echo "$(GREEN)SIDEKIQ container is running$(NC)"
endif

ifeq ($(DOCKER_OPS_CONTAINER_ID),)
	@echo "$(RED)OPS container is not running$(NC)"
else
	@echo "$(GREEN)OPS container is running$(NC)"
endif
endif

s: server
server: start
ifeq ($(wildcard /.dockerenv),)
	docker exec -it $(APP_CONTAINER_NAME) /bin/bash -l -c "make server";
else
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) bundle exec rails s -b 0.0.0.0 -p 3000
endif

sq: sidekiq
sidekiq: start
ifeq ($(wildcard /.dockerenv),)
	docker exec -it $(SIDEKIQ_CONTAINER_NAME) /bin/bash -l -c "make sidekiq";
else
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) bundle exec sidekiq -e $(ENV) -c $(SIDEKIQ_CONCURRENCY)
endif

c: console
console: start
ifeq ($(wildcard /.dockerenv),)
	docker exec -it $(SIDEKIQ_CONTAINER_NAME) /bin/bash -l -c "make console";
else
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) bundle exec rails c
endif
