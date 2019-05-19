require 'test_helper'

class SessionRequestTest < ActiveSupport::TestCase
  test "basic create and send mail" do
    sr = ::SessionRequest.new
    assert !sr.save

    sr.user = users(:one)
    sr.chapter = chapters(:one)
    sr.session_topic = "Test Session"
    sr.session_description = "Session Description"

    assert sr.save

    x = ::ActionMailer::Base.deliveries.find {|x|
      x.subject =~ /New\sSession\sRequest\s##{sr.id}/
    }

    assert x
    assert x.to.is_a? Array
  end
end
