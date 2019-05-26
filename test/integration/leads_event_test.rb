require 'test_helper'

class LeadsEventTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = "1"
    sign_in users(:one)
  end

  teardown do
    ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = nil
  end

  test "Leads create event" do
    event = {
      :name => "Test Event Integration Test",
      :chapter_id => chapters(:one).id,
      :event_type_id => event_types(:one).id,
      :venue_id => event_types(:one).id,
      :start_time => Time.now + 5.days,
      :end_time => Time.now + 10.days
    }

    post leads_events_path, event: event
    assert_response :redirect   # 200-ok means error is rendered 30x-redirect means resource created

    e = ::Event.where(name: "Test Event Integration Test").first
    assert !e.nil?
  end

  test "Leads delete event" do
    event = events(:one)
    
    delete leads_event_path(event)
    assert_response :redirect

    # We DO NOT actually delete the event currently - Refer to leads/events_controller#destroy
    e = ::Event.where(id: event.id).first
    assert !e.nil?
  end

  test "Leads update event" do
    event = events(:one)
    event.start_time += 2.days

    patch leads_event_path(event), event: {
      start_time: event.start_time
    }

    assert_response :redirect

    e = ::Event.where(name: event.read_attribute(:name)).first
    assert e.start_time == event.start_time
  end
end

