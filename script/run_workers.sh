#!/bin/bash

sleep 5
while [ true ]; do
  VVERBOSE=1 QUEUE=* COUNT=1 bundle exec rake resque:workers
done;


