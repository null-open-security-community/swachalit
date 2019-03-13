#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

echo "Building app.."
./script/run_build.sh

echo "Starting workers"
killall -9 resque
./script/run_workers.sh > /dev/null 2>&1 &

echo "Start application server"
killall -9 unicorn_rails
./script/run_app.sh > /dev/null 2>&1 &


