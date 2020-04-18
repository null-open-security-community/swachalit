module OmniAuth
  module Strategies
    # tell OmniAuth to load our strategy
    # Not used for now
    #autoload :Nullwp, File.join(Rails.root.to_s, 'lib/oauth/nullwp_strategy')

    #autoload :Wordpress, File.join(Rails.root.to_s, 'lib/oauth/wordpress')
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/auth'
    config.on_failure = OmniauthsController.action(:failure_callback)
  end

  #provider :wordpress, CFG_OAUTH_NULL_CONSUMER_KEY, CFG_OAUTH_NULL_CONSUMER_SECRET
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end
