require 'test_helper'

class EventRegistrationTest < ActiveSupport::TestCase
  test "visible registration exception" do
    e = events(:two)
    u = ::User.first

    er = e.event_registrations.new
    er.visible = true
    er.event = e
    er.user = u
    
    assert er.save

    assert e.event_registrations.count > 0
    assert e.visible_registrations.includes(:user).count > 0

    # This is where upgrade triggered regression
    assert e.visible_registrations.includes(:user).to_a.slice!(0, 1000).count > 0
  end

  test "test registration validation" do
    e = events(:two)
    u = ::User.first

    # Force update bypassing validation
    assert e.update_column(:registration_end_time, Time.now - 1.day)

    er = e.event_registrations.new
    er.visible = true
    er.event = e
    er.user = u

    assert_not er.save

    # Force reload due to update_column
    e.reload

    e.start_time = Time.now + 10.day
    e.registration_start_time = Time.now + 1.day
    e.registration_end_time = Time.now + 3.days
    e.max_registration = 1

    assert e.save

    u = ::User.second
    er = e.event_registrations.new
    er.visible = true
    er.event = e
    er.user = u

    assert_not e.save
  end

  test "event registration state update" do
    e = events(:two)
    u = ::User.first

    er = e.event_registrations.new
    er.visible = true
    er.event = e
    er.user = u
    
    assert er.save

    assert_nothing_raised do
      er.set_state!('Confirmed')
    end

    assert_raise do
      er.set_state!('Confirmed-INVALID')
    end

    e.max_registration = 1
    e.start_time = Time.now + 1.days
    assert e.save

    assert_nothing_raised do
      er.set_state!('Provisional')
    end
  end
end
