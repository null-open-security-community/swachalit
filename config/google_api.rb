GOOGLE_API_APPLICATION_NAME     = "Swachalit"
GOOGLE_API_APPLICATION_VERSION  = "1.0"
GOOGLE_API_USER_EMAIL           = ENV["GOOGLE_API_USER_EMAIL"]
GOOGLE_API_KEY_PATH             = File.join(File.dirname(__FILE__), 'google_api_key.p12')
GOOGLE_API_KEY_PASSPHRASE       = ENV["GOOGLE_API_KEY_PASSPHRASE"]

if Rails.env.production?
  GOOGLE_API_CALENDAR_ID        = ENV["GOOGLE_API_CALENDAR_ID"]
else
  GOOGLE_API_CALENDAR_ID        = "no-such-calendar"
end
