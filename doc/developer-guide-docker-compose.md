# Developer Guide

## Requirements

1. Docker
2. Docker Compose
3. Visual Studio Code

## Setting up Development Environment

Create `.env` in source root with the following contents

```
RAILS_ENV=development

MYSQL_SERVER=db
MYSQL_DATABASE=swachalit
MYSQL_USERNAME=root
MYSQL_PASSWORD=s0m3p4ssw0rd

MAILCATCHER_HOST=192.168.1.151
MAILCATCHER_PORT=1025

GOOGLE_API_USER_EMAIL=NOT_REQUIRED_FOR_DEV
GOOGLE_API_KEY_PASSPHRASE=NOT_REQUIRED_FOR_DEV
GOOGLE_API_CALENDAR_ID=NOT_REQUIRED_FOR_DEV

IFTTT_SENDER_EMAIL=some@example.com

OAUTH_NULL_CONSUMER_KEY=NOT_REQUIRED_FOR_DEV
OAUTH_NULL_CONSUMER_SECRET=NOT_REQUIRED_FOR_DEV

GOOGLE_CLIENT_ID=NOT_REQUIRED_FOR_DEV
GOOGLE_CLIENT_SECRET=NOT_REQUIRED_FOR_DEV

SECRET_KEY_BASE=SECRET-KEY-DEV-TEST
```

Create `.env.mysql` in source root with the following content

```
MYSQL_ROOT_PASSWORD=s0m3p4ssw0rd
```

Start *only* the application server and MySQL

```
docker-compose -f docker-compose-app.yml up
```

This will build the docker image based on `Dockerfile` and bring up

1. MySQL Server
2. Rails Application Server (in Development Mode)

Check `script/run_docker_app.sh` to see what commands are executed to start the `Rails` application server and bootstrap swachalit.

> This is enough for almost all development activities. The entire stack is not required.

The full application stack consist of following components

1. MySQL Server
2. Redis Server
3. Resque Scheduler
4. Resque Workers

The entire stack can be started with following command

```
docker-compose -f docker-compose-full-stack.yml up
```

## Users for Development Environment

Create users for use in development environment

```
docker-compose -f docker-compose-app.yml rake db:seed
```

This will create 2 users

1. Admin User
2. Normal User

Credentials are available available in `db/seed.rb`

## Accessing Application

Point your browser to `http://localhost:8800`

The admin interface is accessible through `http://localhost:8800/admin`, use the following credentials that are created as part of database setup

```
admin@example.com
password
```

The admin interface can be used to create various resources like chapter, venue, event etc. for testing.
