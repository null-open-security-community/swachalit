# Production Operations

> The information in this document may be deprecated. The production pipeline is managed in Bitbucket but completely rewritten to sync with public docker image and release version.

## SSL/TLS

SSL/TLS and its corresponding security configuration should be handled at frontend reverse proxy. The reverse proxy should forward `/` to Swachalit running on port 8800.

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
