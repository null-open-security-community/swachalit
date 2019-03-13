#!/bin/bash

sleep 5
while [ true ]; do
  bundle exec rake resque:scheduler
done;


