# Testing Swachalit

## Running Test Cases

```
RUBYOPT=-W0 rake test
```

> The `RUBYOPT` environment variable is required to suppress deprecation warnings.

Running in `docker` environment

```
docker-compose -f docker-compose-app.yml run app bash
RUBYOPT=-W0 rake test
```

1. Drop to shell inside the container
2. Run test cases

The `docker-compose-app.yml` mounts current directory inside the container so developers can make changes in test code in their IDE and re-run without exiting the container.

## Example Test

Refer to `test/unit/event_test.rb`
