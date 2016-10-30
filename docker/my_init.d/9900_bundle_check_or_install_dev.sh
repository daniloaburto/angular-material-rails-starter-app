#!/bin/bash

cd /home/app/webapp && (bundle check || bundle install --jobs 4 --retry 6)
