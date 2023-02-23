# null Swachalit

This repository contains source code of application used to run https://null.community

[![CircleCI](https://circleci.com/gh/null-open-security-community/swachalit/tree/master.svg?style=svg)](https://circleci.com/gh/null-open-security-community/swachalit/tree/master)
![Build and Test](https://github.com/null-open-security-community/swachalit/workflows/Rails%20Build%20and%20Test/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/3eeabb4c889ec3e0b285/maintainability)](https://codeclimate.com/github/null-open-security-community/swachalit/maintainability)

## Developer Documentation

* [Developer Environment Setup with Docker Compose](doc/developer-guide-docker-compose.md)
* [Developer Testing](doc/testing.md)
* [Development Environment Setup with Vagrant](doc/vagrant.md)
* [Exposing API Services](doc/exposing-api-services.md)
* [Production Ops](doc/production-ops.md)

## Development Environment

Bring up core web app for development

```
docker-compose up
```

Bring up full stack

```
docker-compose -f docker-compose-full-stack.yml up
```

## Contributors Guide

* Read [Wiki on Getting Started with Contribution](https://github.com/null-open-security-community/swachalit/wiki/Contributing-to-Swachalit-DevOps)
* [Setup a developer environment](doc/developer-guide-docker-compose.md)
* Head over to [open issues](https://github.com/null-open-security-community/swachalit/issues)
