GOOGLE_API_APPLICATION_NAME     = "Swachalit"
GOOGLE_API_APPLICATION_VERSION  = "1.0"
GOOGLE_API_USER_EMAIL           = ENV["GOOGLE_API_USER_EMAIL"]
GOOGLE_API_KEY_PATH             = File.join(File.dirname(__FILE__), 'google_api_key.p12')
GOOGLE_API_KEY_PASSPHRASE       = ENV["GOOGLE_API_KEY_PASSPHRASE"]

# This API key is EXPOSED in frontend as part of Google Maps Javascript SDK
# This API key should have only Maps Javscript API privileged and locked
# to specific websites by referred check to prevent misuse
GOOGLE_MAPS_API_KEY             = ENV["GOOGLE_MAPS_API_KEY"]

if Rails.env.production?
  GOOGLE_API_CALENDAR_ID        = ENV["GOOGLE_API_CALENDAR_ID"]
else
  GOOGLE_API_CALENDAR_ID        = "no-such-calendar"
end
