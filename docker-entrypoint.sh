#!/bin/bash

# Remove server pid file if it exists
rm -f tmp/pids/server.pid

# Start rails application
bundle exec rails s
