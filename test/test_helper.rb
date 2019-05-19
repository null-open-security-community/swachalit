ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def get_random_new_event()
    Event.new({:chapter_id => 1, 
      :event_type_id => 1, 
      :venue_id => 1, 
      :name => "TestEvent #{rand(1000000)}", 
      :start_time => Time.now + 1.days, 
      :end_time => Time.now + 5.days})
  end

end
