require 'test_helper'

class EventSessionTest < ActiveSupport::TestCase
  test "has a reference" do
    assert EventSession.all.count > 0
    assert EventSession.has_a_reference.count == 0

    es = EventSession.last
    es.presentation_url = "AAA"
    assert es.save

    assert EventSession.has_a_reference.count == 1

    es.presentation_url = nil
    es.video_url = "AAA"
    assert es.save

    assert EventSession.has_a_reference.count == 1

    es.video_url = nil
    assert es.save

    assert EventSession.has_a_reference.count == 0

    es.video_url = ""
    assert es.save

    assert EventSession.has_a_reference.count == 0
  end
end
