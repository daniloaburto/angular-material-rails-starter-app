#!/bin/bash

# Install bower
echo "Installing bower globally..."
npm -g install bower@1.7.9

echo "Installing bower packages..."
cd /home/app/webapp && bower install --allow-root
