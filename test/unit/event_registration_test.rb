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
end
