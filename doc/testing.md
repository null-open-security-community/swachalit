# Testing Swachalit

## Running Test Cases

Running in `docker` environment

```
docker-compose run app bash
RUBYOPT=-W0 rake RAILS_ENV=test test
```

1. Drop to shell inside the container
2. Run test cases

The `docker-compose-app.yml` mounts current directory inside the container so developers can make changes in test code in their IDE and re-run without exiting the container.

Run test cases

```
RUBYOPT=-W0 RAILS_ENV=test rake test
```

> The `RUBYOPT` environment variable is required to suppress deprecation warnings.

## Example Test

Refer to `test/unit/event_test.rb`

## Writing Test Cases

Refer to official getting started:
https://guides.rubyonrails.org/testing.html

Use rails helper to generate new test case

```
rails generate integration_test some_test
```

Look inside existing test cases in

* `test/unit`
* `test/integration`

## Writing Test Cases

### Writing Unit Test

> See examples in `test/unit`

### Writing Integration Test

> See examples in `test/integration`

### Authenticated Integration Test

```
setup do
  ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = "1"
  sign_in users(:one)
end
```


* https://guides.rubyonrails.org/testing.html#unit-testing
* https://guides.rubyonrails.org/testing.html#integration-testing
