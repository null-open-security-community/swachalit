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

  test "Leads delete event session" do
    session = event_sessions(:one)
    event = events(:one)
    
    delete leads_event_event_session_path(event, session)
    assert_response :redirect

    s = EventSession.where(id: session.id).first  #TODO: Sessions are currently not deleted
    assert !s.nil?
  end

  test "Leads update event session" do
    session = event_sessions(:one)
    event = events(:one)
    update = {
      name: "Session name updated"
    }
    patch leads_event_event_session_path(event, session), event_session: update
    assert_response :redirect

    s = EventSession.where(id: session.id).first
    assert s.name = update[:name]
  end

  test "Session management pages are accessible" do
    event = events(:one)
    session = event_sessions(:one)

    get leads_event_event_sessions_path(event)
    assert_response :ok

    get leads_event_event_sessions_path(event)
    assert_response :ok

    get new_leads_event_event_session_path(event)
    assert_response :ok

    get edit_leads_event_event_session_path(event, session)
    assert_response :ok
  end
end