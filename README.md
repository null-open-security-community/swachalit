# null Swachalit

This repository contains source code of application used to run https://null.co.in

## Production

Production deployment is triggered through Git release tag of format:

```
release-x.x.x
```

The `x.x.x` conforms to semantic versioning.

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


