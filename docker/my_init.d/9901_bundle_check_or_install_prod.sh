#!/bin/bash

bundle check || bundle install --deployment --jobs 4 --retry 6 --without development test
