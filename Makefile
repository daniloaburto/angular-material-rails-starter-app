# Include environment variables from .env
include .env

RAILS_CMD=bin/rails
RAKE_CMD=bin/rake

# Colors
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m # No Color

# If code is executed inside a container
ifneq ($(wildcard /.dockerenv),)
	DOCKER_HOST_IP := $(shell /sbin/ip route|awk '/default/ { print $$3 }')
else
	DOCKER_APP_CONTAINER_ID := $(shell docker ps --filter="name=$(APP_CONTAINER_NAME)" -q)
endif

init: create
#
clean_db:
	$(RAKE_CMD) db:drop:all RAILS_ENV=$(ENV);	# Drop DB
	$(RAKE_CMD) db:create RAILS_ENV=$(ENV);		# Create DB
	$(RAKE_CMD) db:migrate RAILS_ENV=$(ENV);		# Create DB tables and relations - Used for version control

# Models
scaffold_models:
	$(RAILS_CMD) g scaffold User \
		first_name:string{255} \
		last_name:string{255} \
		enabled:boolean \
		role:integer{4};

	$(RAILS_CMD) g scaffold Country \
		name:string{255};
	#
	# $(RAILS_CMD) g scaffold Parameter \
	# 	key:string{255} \
	# 	value:string{255};

destroy_models:
	$(RAILS_CMD) d scaffold User;
	$(RAILS_CMD) d scaffold Country;
	# $(RAILS_CMD) d scaffold Parameter;

# Devise
enable_devise:
	$(RAILS_CMD) generate devise:install
	$(RAILS_CMD) generate devise User

disable_devise:
	$(RAILS_CMD) destroy devise:install
	$(RAILS_CMD) destroy devise User

# Policies
scaffold_policies:
	$(RAILS_CMD) g pundit:policy user;
	$(RAILS_CMD) g pundit:policy country;
	# $(RAILS_CMD) g pundit:policy parameter;

destroy_policies:
	$(RAILS_CMD) d pundit:policy user;
	$(RAILS_CMD) d pundit:policy country;
	# $(RAILS_CMD) d pundit:policy parameter;

# Database
create:
	# $(RAKE_CMD) db:schema:load;	# Load db schema (Delete and Create empty DB)
	# $(RAKE_CMD) db:drop:all;		# Drop DB
	$(RAKE_CMD) db:create;			# Create DB if doesn't exists
	$(RAKE_CMD) db:clear;			# Drop tables from environment related db
	$(RAKE_CMD) db:migrate;		# Create tables and relations - Used for version control

seed:
	$(RAKE_CMD) db:seed

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
endif

s: server
server: start
ifeq ($(wildcard /.dockerenv),)
	docker exec -it $(APP_CONTAINER_NAME) /bin/bash -l -c "make server";
else
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) $(RAILS_CMD) s -b 0.0.0.0 -p 3000
endif

sq: sidekiq
sidekiq: start
ifeq ($(wildcard /.dockerenv),)
	docker exec -it $(APP_CONTAINER_NAME) /bin/bash -l -c "make sidekiq";
else
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) bundle exec sidekiq -e $(ENV) -c $(SIDEKIQ_CONCURRENCY)
endif

c: console
console: start
ifeq ($(wildcard /.dockerenv),)
	docker exec -it $(APP_CONTAINER_NAME) /bin/bash -l -c "make console";
else
	TRUSTED_IP=$(DOCKER_HOST_IP) RAILS_ENV=$(ENV) $(RAILS_CMD) c
endif
