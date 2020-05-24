require 'test_helper'

class EventsSessionsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Only authenticated user should access my sessions page" do
    get my_event_sessions_path
    assert_response :redirect

    sign_in users(:one)

    get my_event_sessions_path
    assert_response :success
  end
end
