# null Swachalit

This repository contains source code of application used to run https://null.co.in

[![CircleCI](https://circleci.com/gh/null-open-security-community/swachalit/tree/master.svg?style=svg)](https://circleci.com/gh/null-open-security-community/swachalit/tree/master)

## Developer Documentation

* [Developer Environment Setup with Docker Compose](doc/developer-guide-docker-compose.md)
* [Developer Testing](doc/testing.md)
* [Development Environment Setup with Vagrant](doc/vagrant.md)
* [Exposing API Services](doc/exposing-api-services.md)

## Production

Production deployment is triggered through Git release tag of format:

```
release-x.x.x
```

The `x.x.x` conforms to semantic versioning.

Push a release through git

```
git tag -a -m "Release for XYZ" release-X.Y.Z
git push origin --tags
```

### Production Environment

The entire deployment, including secrets are managed through Bitbucket pipeline.
Refer to `bitbucket-pipelines.yml` for detail.

Secrets are available during build process as part of Bitbucket pipeline environment variable.

### Manual Build

Look at `prodrun.sh`

### Stop Containers

```
docker rm --force `docker ps -q`
```

**NOTE:** The above command will stop all running containers in the system

## Developer Environment

Bring up full stack

```
docker-compose up
```

Bring up on web app

```
docker-compose -f docker-compose-app.yml up
```

## SSL/TLS

SSL/TLS and its corresponding security configuration should be handled at frontend reverse proxy. The reverse proxy should forward `/` to Swachalit running on port 8800.


