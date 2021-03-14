# Developer Guide

## Requirements

1. Docker
2. Docker Compose
3. Visual Studio Code

### Windows

If you are on Windows but not on latest versions *(1903)* of Windows 10, you need to to use the [Vagrantfile](https://github.com/null-open-security-community/swachalit/blob/master/Vagrantfile) with [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html). Refer to [Setting up Development Environment with Vagrant](vagrant.md). 

If you are using relatively latest 64 bit Windows 10 version *(1903 or higher)*, you may consider using [Docker for Desktop](https://docs.docker.com/docker-for-windows/install-windows-home/) with [WSL2 backend](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

## Clone Repository

```
git clone https://github.com/null-open-security-community/swachalit
```

> *Note:* The above command clones over HTTP anonymously. If you have Github account and configured SSH keys then you must clone over SSH to push changes to your forked repository.

## Setting up Development Environment

Create a file named `.env` in source root with the following contents

```
RAILS_ENV=development

MYSQL_SERVER=db
MYSQL_DATABASE=swachalit
MYSQL_USERNAME=root
MYSQL_PASSWORD=s0m3p4ssw0rd

MAILCATCHER_HOST=127.0.0.1
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

STORAGE_PROVIDER_DISABLED=true
```

Create a file named `.env.mysql` in source root with the following content

```
MYSQL_ROOT_PASSWORD=s0m3p4ssw0rd
```

Start *only* the application server and MySQL

```
docker-compose up
```

This will build the docker image based on `Dockerfile` and bring up

1. MySQL Server
2. Rails Application Server (in Development Mode)

Once both the containers are running, point your browser to `http://localhost:8800`. Refer to `dummy data seeding` later in the document on how to seed database and create dummy users.

**Optional:** Check `script/run_docker_app.sh` to see what commands are executed to start the `Rails` application server and bootstrap swachalit.

> This is enough for almost all development activities. The entire stack is not required.

## Running Test Cases

```
docker-compose run app rake test RAILS_ENV=test
```

## Full Stack Developer Environment

> *Optional:* The full stack is NOT required for developing the core application backend and frontend. This is required only if you are working on background jobs.

The full application stack consist of following components

1. Rails Application Server
2. MySQL Server
3. Redis Server
4. Resque Scheduler
5. Resque Workers

The entire stack can be started with following command

```
docker-compose -f docker-compose-full-stack.yml up
```

## Dummy Data for Development Environment

Populate the database with dummy data for use in development environment *AFTER* your application is up and running with `docker-compose` and you are able to access Swachalit using your web browser.

```
docker-compose run app rake db:seed
```

This will create 2 users

1. Admin User
2. Normal User

Credentials are available available in `db/seed.rb` or read `Accessing Application` section in this document.

To drop all data and re-populate seed data:

```
docker-compose run app rake db:migrate VERSION=0
docker-compose run app rake db:migrate
docker-compose run app rake db:seed
```

## Accessing Application

Point your browser to `http://localhost:8800` and login with

```
developer@localhost.local
password
```

The admin interface is accessible through `http://localhost:8800/admin`, use the following credentials that are created as part of database setup

```
admin@example.com
password
```

The admin interface can be used to create various resources like chapter, venue, event etc. for testing.
