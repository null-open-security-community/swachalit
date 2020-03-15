
require 'test_helper'
require 'ostruct'

class SecurityTest < ActiveSupport::TestCase
  include ApplicationHelper

  test "stored xss with safe_url" do
    payload = "javascri\npt:alert`\nhttps://test.com`"
    assert safe_url(payload) !~ /^java/i
  end

  test "newline handling in safe_url" do
    payload = "ping\nhttp://\rBBBBB"
    assert safe_url(payload) == "http://pinghttp://BBBBB"
  end
end
