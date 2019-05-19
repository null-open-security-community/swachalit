require 'test_helper'

class SessionProposalTest < ActiveSupport::TestCase
  test "creation of session proposal" do    
    sp = ::SessionProposal.new
    assert !sp.save

    sp.user = users(:one)
    sp.chapter = chapters(:one)
    sp.event_type = event_types(:one)
    sp.session_topic = "Test Session"
    sp.session_description = "Session Description"

    assert sp.save

    x = ::ActionMailer::Base.deliveries.find {|x|
      x.subject =~ /New\sSession\sProposal\s##{sp.id}/
    }

    assert x
    assert x.to.is_a? Array
  end
end
