Raven.configure do |config|
  config.dsn = CFG_SENTRY_DSN
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = ['production']
end
