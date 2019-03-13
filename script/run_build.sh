#!/bin/bash

bundle install
bundle exec rake db:migrate
RAILS_ENV=production rake assets:precompile


