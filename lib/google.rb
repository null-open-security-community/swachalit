require 'google/api_client'

module GoogleAPI
  autoload :ServiceClient, File.join(File.dirname(__FILE__), 'google', 'service_client')
  autoload :ServiceClientFactory, File.join(File.dirname(__FILE__), 'google', 'service_client')
  autoload :CalendarEvent, File.join(File.dirname(__FILE__), 'google', 'calendar')
  autoload :CalendarV3, File.join(File.dirname(__FILE__), 'google', 'calendar')
end