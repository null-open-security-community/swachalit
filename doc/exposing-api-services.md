# Exposing API Services

API services are exposed using `Grape` middleware.

The API handlers are available in `lib/api` directory.

The following route mounts Grape Swachalit API which in turn mounts other routes:

```
mount ::API::Swachalit => '/api-v2'
```

## Exposing a Resource as API

1. Create resource file under `lib/api`
2. Include the file in `lib/api/swachalit.rb`
3. Mount the resource class

See `lib/api/event.rb` and `lib/api/swachalit.rb` for reference.