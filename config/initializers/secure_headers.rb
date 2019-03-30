::SecureHeaders::Configuration.configure do |config|
  config.cookies = { secure: true, httponly: true }
  config.x_frame_options = 'DENY'
  config.x_content_type_options = "nosniff"
  config.hsts = "max-age=#{20.years.to_i}; includeSubdomains"
  config.csp = ::SecureHeaders::OPT_OUT
  config.referrer_policy = "origin"
end


