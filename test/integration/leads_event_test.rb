require 'test_helper'

class LeadsEventTest < ActionDispatch::IntegrationTest

  test "Leads create event" do
    event = {
      :name => "Test Event Integration Test",
      :chapter_id => chapters(:one),
      :event_type_id => event_types(:one),
      :venue_id => event_types(:one),
      :start_time => Time.now + 5.days,
      :end_time => Time.now + 10.days
    }

    post leads_events_path, event: event
    assert_response :redirect   # 200-ok means error is rendered 30x-redirect means resource created

    e = ::Event.where(name: "Test Event Integration Test")
    assert !e.nil?
  end

  test "Leads delete event" do
    event = events(:one)
    
    delete leads_event_path(event)
    assert_response :redirect

    e = ::Event.where(name: event.name).first
    assert e.nil?
  end

  test "Leads update event" do
    event = events(:one)
    event.start_time += 2.days

    patch leads_event_path(event), event:event
    assert_response :redirect

    e = ::Event.where(name: event.name).first
    assert e.start_time == event.start_time
  end
end

