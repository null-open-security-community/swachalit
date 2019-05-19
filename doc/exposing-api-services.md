# Exposing API Services

API services are exposed using `Grape` middleware.

The API handlers are available in `lib/api` directory.

The following route mounts Grape Swachalit API which in turn mounts other routes:

```
mount ::API::Swachalit => '/api-v2'
```