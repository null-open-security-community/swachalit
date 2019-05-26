require 'test_helper'

class LeadsEventsSessionsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  teardown do
  end

  test "Leads create new session" do
    event = events(:one)
    speaker = users(:two)
    session = {
      event_id:     event.id,
      user_id:      users(:two).id,
      name:         "Event1::Session1", 
      description:  "Session 1 for Event 1",
      start_time:   event.start_time + 5.minutes,
      end_time:     event.start_time + 30.minutes
    }

    post leads_event_event_sessions_path(event), event_session: session
    assert_response :redirect
    
    sess = EventSession.where(name: session[:name]).first
    assert !sess.nil?
    assert sess.speaker_name == speaker.name
  end
end 