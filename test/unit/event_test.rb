require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should not save event without name" do
    event = Event.new
    assert !event.save
  end

  test "fixture should be valid" do
    e = events(:one)
    assert e.save
  end

  test "end time should not be less than start time" do
    e = events(:one)
    e.end_time = e.start_time - 1.day
    assert !e.save
  end

  test "start time should not be in the past" do
    e = events(:one)
    e.start_time = Time.now - 2.days
    e.end_time = Time.now
    assert !e.save
  end

  test "event notification manager states" do
    e = get_random_new_event()
    e.save

    assert e.notification_state == ::EventNotification::STATE_INIT, "state: #{e.notification_state}"
    e.execute_notifications()
    e.reload()
    assert e.notification_state == ::EventNotification::STATE_INITIAL_NOTIFICATIONS, "state: #{e.notification_state}"
    e.execute_first_reminder()
    e.reload()
    assert e.notification_state == ::EventNotification::STATE_FIRST_REMINDER, "state: #{e.notification_state}"
    e.execute_second_reminder()
    e.reload()
    assert e.notification_state == ::EventNotification::STATE_SECOND_REMINDER, "state: #{e.notification_state}"
  end

  test "descriptive name" do
    e = events(:one)

    assert e.descriptive_name.index(e.chapter.name) != nil
    assert e.descriptive_name.index(e.event_type.name) != nil
    assert e.descriptive_name.index(e.start_time.strftime('%d %B %Y')) != nil
  end

  test "descriptive start time" do
    e = events(:one)
    assert e.descriptive_start_time.index(e.start_time.year.to_s) != nil
  end

  test "user managed chapters" do
    u = users(:one)

    assert u.managed_chapters.is_a?(::Array)
  end

  test "user managed venues" do
    u = users(:one)

    assert u.managed_venues.is_a?(::ActiveRecord::Relation)
    assert u.managed_venues.map(&:id).include?(1)
    assert !u.managed_venues.map(&:id).include?(2)
  end

end
