#!/bin/bash

# Wait for DB to initialize
sleep 5

# Setup DB and migrations
bundle exec rake db:create
bundle exec rake db:migrate

rm -rf tmp/pids/*

if [ "$RAILS_ENV" == "production" ]; then
  bundle exec rake assets:precompile
  unicorn_rails -c config/unicorn.rb
else    
  rails s -b 0.0.0.0 -p 8800
fi;


