require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Required to hide some ActiveAdmin realted warning
I18n.enforce_available_locales = false

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module NullifyPlatform
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Kolkata'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # Deprecated in Rails 4+
    # config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.after_initialize do
        require File.join(Rails.root.to_s, 'lib', 'workers')
    end
  end
end

if Rails.env.development?
    Rails.application.routes.default_url_options[:host] = '127.0.0.1'
else
    Rails.application.routes.default_url_options[:host] = 'null.co.in'
end

require 'dotenv/load'

# TODO: Clean this up with require_relative
require File.join(Rails.root.to_s, 'config', 'null_oauth')
require File.join(Rails.root.to_s, 'config', 'mailgun')
require File.join(Rails.root.to_s, 'config', 'misc_config')
require File.join(Rails.root.to_s, 'config', 'google_api')
require File.join(Rails.root.to_s, 'config', 'twitter')
require File.join(Rails.root.to_s, 'config', 'storage')
require File.join(Rails.root.to_s, 'config', 'slack')
require File.join(Rails.root.to_s, 'config', 'recaptcha')

require File.join(Rails.root.to_s, 'lib', 'scheduler', 'resque_helper')
require File.join(Rails.root.to_s, 'lib', 'google')
require File.join(Rails.root.to_s, 'lib', 'integrations', 'twitter')
require File.join(Rails.root.to_s, 'lib', 'api')

# Ensure this is always loaded last
require File.join(Rails.root.to_s, 'lib', 'patches')
