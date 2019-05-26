require 'test_helper'

class EventsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Unsupported methods by events" do
    sign_in users(:one)

    new_event = {
      :name => "Test Event Integration Test",
      :chapter_id => chapters(:one).id,
      :event_type_id => event_types(:one).id,
      :venue_id => event_types(:one).id,
      :start_time => Time.now + 5.days,
      :end_time => Time.now + 10.days
    }

    assert_raise (AbstractController::ActionNotFound) {get events_path}
    assert_raise (AbstractController::ActionNotFound) {post events_path, event: new_event}
  end

  test "Unspported methods by event" do
    event = events(:one)
    assert_raise (AbstractController::ActionNotFound) {put event_path(event), event: {start_time: Time.now}}
    assert_raise (AbstractController::ActionNotFound) {delete event_path(event)}
  end

  test "Show event" do
    event = events(:one)
    get event_path(event)
    assert_response :ok
  end
end