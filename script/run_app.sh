#!/bin/bash

RAILS_ENV=production unicorn_rails -c config/unicorn.rb


